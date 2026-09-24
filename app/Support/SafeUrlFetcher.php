<?php

namespace App\Support;

use Illuminate\Http\Client\Response;
use Illuminate\Support\Facades\Http;
use InvalidArgumentException;
use Symfony\Component\HttpFoundation\IpUtils;

/**
 * Fetches admin-supplied URLs (e.g. manufacturer spec pages) without letting them
 * reach internal services: only public http(s) hosts, no redirects, pinned DNS.
 */
class SafeUrlFetcher
{
    public static function get(string $url, int $timeout = 10): Response
    {
        [$host, $port, $ips] = static::resolvePublicTarget($url);

        return Http::timeout($timeout)
            ->withUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) BotbleBot/1.0')
            ->withOptions([
                'allow_redirects' => false,
                // Pin the connection to the address we validated, so a second DNS lookup
                // cannot be rebound to an internal IP.
                'curl' => [CURLOPT_RESOLVE => ["{$host}:{$port}:{$ips[0]}"]],
            ])
            ->get($url);
    }

    /**
     * @return array{0: string, 1: int, 2: array<int, string>}
     */
    public static function resolvePublicTarget(string $url): array
    {
        $parts = parse_url($url);
        $scheme = strtolower($parts['scheme'] ?? '');
        $host = $parts['host'] ?? '';

        if (! in_array($scheme, ['http', 'https'], true) || $host === '' || isset($parts['user']) || isset($parts['pass'])) {
            throw new InvalidArgumentException('Only public http(s) URLs are allowed.');
        }

        $port = (int) ($parts['port'] ?? ($scheme === 'https' ? 443 : 80));
        $host = trim($host, '[]');

        if (filter_var($host, FILTER_VALIDATE_IP)) {
            $ips = [$host];
        } else {
            $ips = array_values(array_unique(array_merge(
                array_column(@dns_get_record($host, DNS_A) ?: [], 'ip'),
                array_column(@dns_get_record($host, DNS_AAAA) ?: [], 'ipv6'),
            )));
        }

        if ($ips === []) {
            throw new InvalidArgumentException('The URL host could not be resolved.');
        }

        foreach ($ips as $ip) {
            if (! static::isPublicIp($ip)) {
                throw new InvalidArgumentException('The URL points to a private or reserved address.');
            }
        }

        return [$host, $port, $ips];
    }

    public static function isPublicIp(string $ip): bool
    {
        if (! filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE)) {
            return false;
        }

        // Ranges PHP's filter does not treat as private/reserved but that are not public internet.
        return ! IpUtils::checkIp($ip, [
            '100.64.0.0/10',  // carrier-grade NAT
            '192.0.0.0/24',   // IETF protocol assignments
            '198.18.0.0/15',  // benchmarking
            '::ffff:0:0/96',  // IPv4-mapped IPv6
            '64:ff9b::/96',   // NAT64
        ]);
    }
}
