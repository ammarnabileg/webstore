<?php

namespace Tests\Unit;

use Botble\SystemWizard\Services\RecommendationService;
use Botble\SystemWizard\Services\WizardCatalog;
use PHPUnit\Framework\TestCase;

class RecommendationServiceTest extends TestCase
{
    protected function service(): RecommendationService
    {
        $item = fn (string $name, float $price) => ['name' => $name, 'price' => $price, 'available' => true];
        $tiers = fn (string $name, float $price) => [
            'basic' => $item($name, $price), 'pro' => $item($name, $price), 'prem' => $item($name, $price),
        ];

        $catalog = $this->createMock(WizardCatalog::class);
        $catalog->method('get')->willReturn([
            'camera' => [
                'basic' => ['in' => $item('cam-in', 10), 'out' => $item('cam-out', 15), 'gbDay' => 12],
                'pro' => ['in' => $item('cam-in', 20), 'out' => $item('cam-out', 25), 'gbDay' => 20],
                'prem' => ['in' => $item('cam-in', 30), 'out' => $item('cam-out', 40), 'gbDay' => 35],
            ],
            'ptz' => $item('ptz', 95),
            'nvr' => array_fill_keys([8, 16, 32], ['basic' => 50, 'pro' => 60, 'prem' => 80]),
            'hdd' => ['sizes' => WizardCatalog::HDD_SIZES, 'price' => array_fill_keys(WizardCatalog::HDD_SIZES, 30)],
            'poeSwitch' => ['ports' => WizardCatalog::POE_PORTS, 'price' => array_fill_keys(WizardCatalog::POE_PORTS, 20)],
            'ap' => $tiers('ap', 38) + ['controller' => $item('ctrl', 45)],
            'intercom' => $tiers('intercom', 60),
            'alarm' => $tiers('alarm', 95),
            'router4g' => $item('router', 32),
            'netPoint' => $tiers('net', 7),
            'tvPoint' => $tiers('tv', 8),
            'rack' => $tiers('rack', 28),
            'installPerPoint' => 8,
            'whatsappNumber' => '',
        ]);

        return new RecommendationService($catalog);
    }

    public function test_question_heuristic_counts_cameras(): void
    {
        $counts = $this->service()->camCounts([
            'goals' => ['entry', 'indoor', 'perimeter'], 'area' => 1, 'entrances' => 1, 'outdoor' => true,
        ]);

        // entrances idx 1 => 2 outdoor, indoor by area idx 1 => 3, perimeter by area idx 1 => 3
        $this->assertSame(['indoor' => 3, 'outdoor' => 5], $counts);
    }

    public function test_sketch_pins_override_questions_and_follow_zone_labels(): void
    {
        $sketch = [
            'rooms' => [
                ['x' => 0, 'y' => 0, 'w' => 50, 'h' => 50, 'label' => 'صالة', 'floor' => 'g'],
                ['x' => 50, 'y' => 0, 'w' => 50, 'h' => 50, 'label' => 'حوش', 'floor' => 'g'],
            ],
            'pins' => [
                ['t' => 'cam', 'x' => 10, 'y' => 10, 'floor' => 'g'],  // indoor room
                ['t' => 'cam', 'x' => 60, 'y' => 10, 'floor' => 'g'],  // outdoor-labelled room
                ['t' => 'cam', 'x' => 10, 'y' => 90, 'floor' => 'g'],  // outside every room
                ['t' => 'cam', 'x' => 10, 'y' => 10, 'floor' => 'f1'], // no rooms on that floor
            ],
        ];

        $counts = $this->service()->camCounts([
            'goals' => ['indoor'], 'area' => 3, 'sketch' => $sketch,
        ]);

        $this->assertSame(['indoor' => 1, 'outdoor' => 3], $counts);
    }

    public function test_package_total_is_computed_server_side(): void
    {
        $package = $this->service()->buildPackage([
            'place' => 'villa', 'area' => 1, 'floors' => 1, 'entrances' => 1, 'outdoor' => true,
            'condition' => 1, 'goals' => ['entry'], 'recordDays' => 2, 'internet' => 'yes', 'zoom' => false,
        ], 'pro');

        // 2 outdoor cams (2 x 25) + NVR 60 + HDD 30 + PoE switch 20 + install 2 points x 8 x 1.0
        $this->assertSame(50 + 60 + 30 + 20 + 16, $package['total']);
        $this->assertSame('pro', $package['tier']);
        $this->assertCount(5, $package['items']);
    }

    public function test_ready_conduits_remove_the_finished_building_surcharge(): void
    {
        $answers = ['area' => 0, 'floors' => 0, 'entrances' => 0, 'outdoor' => false, 'goals' => ['entry'], 'internet' => 'yes'];

        $finished = $this->service()->buildPackage($answers + ['condition' => 2, 'conduits' => 'no'], 'basic');
        $ready = $this->service()->buildPackage($answers + ['condition' => 2, 'conduits' => 'yes'], 'basic');

        // 1 camera = 1 install point (the switch is not a point): round(1 x 8 x 1.35) = 11 vs 8
        $this->assertSame(3, $finished['total'] - $ready['total']);
    }
}
