<?php

namespace Botble\SystemWizard\Services;

/**
 * Server-side port of the wizard's package engine (camCounts, apCount, buildPackage,
 * classifyPin in SystemWizard.vue). Leads are priced here; totals sent by the browser
 * are never trusted. Keep both implementations in sync.
 */
class RecommendationService
{
    /** Option tables: index = answer index sent by the wizard. */
    public const AREA_MID = [80, 175, 375, 650];

    public const FLOORS = [1, 2, 3];

    public const ENTRANCES = [1, 2, 3, 4];

    public const CONDITION_FACTOR = [0.9, 1.0, 1.35];

    public const RECORD_DAYS = [7, 14, 30, 90, 180];

    public const RECORD_LABELS = ['أسبوع', 'أسبوعين', 'شهر', '3 أشهر', '6 أشهر'];

    public const INDOOR_BY_AREA = [2, 3, 5, 8];

    public const PERIMETER_BY_AREA = [2, 3, 4, 6];

    public const TIER_TITLES = [
        'basic' => 'الباقة الأساسية',
        'pro' => 'الباقة الاحترافية',
        'prem' => 'الباقة المميزة',
    ];

    /**
     * Outdoor room-type ids (spec rule 6). Rooms are sent as stable ids (see the SPA
     * useSketch VOCAB), so zone classification never depends on display text — the label
     * can be translated/reworded freely without moving the price. Unknown ids count as indoor.
     */
    public const OUTDOOR_LABELS = ['yard', 'garden', 'garage', 'parking', 'balcony', 'courtyard'];

    public function __construct(protected WizardCatalog $catalog)
    {
    }

    /**
     * @param  array  $a  normalized answers (see validation rules in PublicSystemWizardController)
     * @return array{tier: string, title: string, items: array<int, array{name: string, qty: int}>, total: int}
     */
    public function buildPackage(array $a, string $tier): array
    {
        $catalog = $this->catalog->get();
        $items = [];
        $total = 0.0;
        $add = function (string $name, int $qty, float $unitPrice) use (&$items, &$total): void {
            $items[] = ['name' => $name, 'qty' => $qty];
            $total += $qty * $unitPrice;
        };

        ['indoor' => $indoor, 'outdoor' => $outdoor] = $this->camCounts($a);
        $zoom = ! empty($a['zoom']);

        if ($indoor > 0) {
            $add($catalog['camera'][$tier]['in']['name'], $indoor, $catalog['camera'][$tier]['in']['price']);
        }
        if ($outdoor > 0) {
            $add($catalog['camera'][$tier]['out']['name'], $outdoor, $catalog['camera'][$tier]['out']['price']);
        }
        if ($zoom) {
            $add($catalog['ptz']['name'], 1, $catalog['ptz']['price']);
        }

        $cams = $indoor + $outdoor + ($zoom ? 1 : 0);

        if ($cams > 0) {
            $channels = $this->pickSize(WizardCatalog::NVR_CHANNELS, $cams);
            $add("جهاز تسجيل NVR {$channels} قناة", 1, (float) $catalog['nvr'][$channels][$tier]);

            $recordIdx = $a['recordDays'] ?? null;
            $days = $recordIdx !== null ? self::RECORD_DAYS[$recordIdx] : 14;
            $recLabel = $recordIdx !== null ? self::RECORD_LABELS[$recordIdx] : 'أسبوعين';
            $tbNeeded = ($cams * $days * $catalog['camera'][$tier]['gbDay']) / 1000;
            $sizes = $catalog['hdd']['sizes'];
            $maxDrive = end($sizes);

            if ($tbNeeded <= $maxDrive) {
                $tb = $this->pickSize($sizes, $tbNeeded);
                $add("قرص تخزين للمراقبة {$tb} تيرابايت (يكفي {$recLabel})", 1, (float) $catalog['hdd']['price'][$tb]);
            } else {
                $add("قرص تخزين للمراقبة {$maxDrive} تيرابايت (يكفي {$recLabel})", (int) ceil($tbNeeded / $maxDrive), (float) $catalog['hdd']['price'][$maxDrive]);
            }
        }

        // IP cameras always need network infrastructure (spec rule 2).
        $aps = $this->apCount($a);
        if ($cams + $aps > 0) {
            $ports = $this->pickSize(WizardCatalog::POE_PORTS, $cams + $aps + 2);
            $add("سويتش PoE {$ports} منفذ", 1, (float) $catalog['poeSwitch']['price'][$ports]);
        }
        if ($aps > 0) {
            $add($catalog['ap'][$tier]['name'], $aps, $catalog['ap'][$tier]['price']);
            if ($aps > 3) {
                $add($catalog['ap']['controller']['name'], 1, $catalog['ap']['controller']['price']);
            }
        }

        $goals = $a['goals'] ?? [];
        if (in_array('intercom', $goals, true)) {
            $add($catalog['intercom'][$tier]['name'], 1, $catalog['intercom'][$tier]['price']);
        }
        if (in_array('alarm', $goals, true)) {
            $add($catalog['alarm'][$tier]['name'], 1, $catalog['alarm'][$tier]['price']);
        }
        if (($a['internet'] ?? null) === 'no' && $cams > 0) {
            $add($catalog['router4g']['name'], 1, $catalog['router4g']['price']);
        }

        $pins = $a['sketch']['pins'] ?? [];
        $nets = count(array_filter($pins, fn ($p) => ($p['t'] ?? null) === 'net'));
        $tvs = count(array_filter($pins, fn ($p) => ($p['t'] ?? null) === 'tv'));
        $hasRack = (bool) array_filter($pins, fn ($p) => ($p['t'] ?? null) === 'rack');

        if ($nets) {
            $add($catalog['netPoint'][$tier]['name'], $nets, $catalog['netPoint'][$tier]['price']);
        }
        if ($tvs) {
            $add($catalog['tvPoint'][$tier]['name'], $tvs, $catalog['tvPoint'][$tier]['price']);
        }
        if ($hasRack) {
            $add($catalog['rack'][$tier]['name'], 1, $catalog['rack'][$tier]['price']);
        }

        $points = $cams + $aps + $nets + $tvs + ($hasRack ? 1 : 0)
            + (in_array('intercom', $goals, true) ? 1 : 0)
            + (in_array('alarm', $goals, true) ? 3 : 0);

        if ($points > 0) {
            $condition = $a['condition'] ?? null;
            $factor = $condition !== null ? self::CONDITION_FACTOR[$condition] : 1.0;
            $readyConduits = $condition === 2 && ($a['conduits'] ?? null) === 'yes';
            if ($readyConduits) {
                $factor = 1.0;
            }

            $items[] = [
                'name' => $readyConduits
                    ? 'تركيب عبر التمديدات الجاهزة (تقديري)'
                    : ($condition === 2 ? 'تركيب وتمديدات عبر مجارٍ خارجية (تقديري)' : 'تركيب وتمديدات (تقديري)'),
                'qty' => 1,
            ];
            $total += round($points * $catalog['installPerPoint'] * $factor);
        }

        return [
            'tier' => $tier,
            'title' => self::TIER_TITLES[$tier],
            'items' => $items,
            'total' => (int) round($total),
        ];
    }

    /**
     * Cameras drawn on the sketch override the question heuristic (spec rule 6).
     *
     * @return array{indoor: int, outdoor: int}
     */
    public function camCounts(array $a): array
    {
        $sketch = $this->sketchCams($a['sketch'] ?? null);
        if ($sketch['in'] + $sketch['out'] > 0) {
            return ['indoor' => $sketch['in'], 'outdoor' => $sketch['out']];
        }

        $goals = $a['goals'] ?? [];
        $wantsCams = (bool) array_intersect($goals, ['entry', 'indoor', 'perimeter']);
        $area = $a['area'] ?? null;

        if (! $wantsCams || $area === null) {
            return ['indoor' => 0, 'outdoor' => 0];
        }

        $indoor = 0;
        $outdoor = 0;

        if (in_array('entry', $goals, true) && ($a['entrances'] ?? null) !== null) {
            $outdoor += self::ENTRANCES[$a['entrances']];
        }
        if (in_array('indoor', $goals, true)) {
            $indoor += self::INDOOR_BY_AREA[$area];
        }
        if (in_array('perimeter', $goals, true) && ! empty($a['outdoor'])) {
            $outdoor += self::PERIMETER_BY_AREA[$area];
        }

        return ['indoor' => $indoor, 'outdoor' => $outdoor];
    }

    public function apCount(array $a): int
    {
        $pins = $a['sketch']['pins'] ?? [];
        $sketchAps = count(array_filter($pins, fn ($p) => ($p['t'] ?? null) === 'ap'));
        if ($sketchAps > 0) {
            return $sketchAps;
        }

        if (! in_array('wifi', $a['goals'] ?? [], true) || ($a['area'] ?? null) === null || ($a['floors'] ?? null) === null) {
            return 0;
        }

        $n = max(self::FLOORS[$a['floors']], (int) ceil(self::AREA_MID[$a['area']] / 140));

        if (($a['devices'] ?? null) === 2) {
            $n++;
        }

        return $n;
    }

    /**
     * A camera pin takes the zone type of the room it sits in (same floor); outside every
     * room it is outdoor/perimeter.
     *
     * @return array{in: int, out: int}
     */
    public function sketchCams(?array $sketch): array
    {
        $counts = ['in' => 0, 'out' => 0];

        foreach ($sketch['pins'] ?? [] as $pin) {
            if (($pin['t'] ?? null) === 'cam') {
                $counts[$this->classifyPin($pin, $sketch['rooms'] ?? [])]++;
            }
        }

        return $counts;
    }

    public function classifyPin(array $pin, array $rooms): string
    {
        $type = 'out';
        $floor = $pin['floor'] ?? 'g';

        foreach ($rooms as $room) {
            if (($room['floor'] ?? 'g') === $floor
                && $pin['x'] >= $room['x'] && $pin['x'] <= $room['x'] + $room['w']
                && $pin['y'] >= $room['y'] && $pin['y'] <= $room['y'] + $room['h']) {
                $type = $this->zoneType((string) ($room['label'] ?? ''));
            }
        }

        return $type;
    }

    public function zoneType(string $label): string
    {
        return in_array($label, self::OUTDOOR_LABELS, true) ? 'out' : 'in';
    }

    protected function pickSize(array $list, float|int $need): int
    {
        foreach ($list as $size) {
            if ($size >= $need) {
                return $size;
            }
        }

        return end($list);
    }
}
