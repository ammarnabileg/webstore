<?php

namespace Tests\Unit;

use App\Support\SafeUrlFetcher;
use InvalidArgumentException;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;

class SafeUrlFetcherTest extends TestCase
{
    public static function blockedUrls(): array
    {
        return [
            'cloud metadata' => ['http://169.254.169.254/latest/meta-data/'],
            'loopback' => ['http://127.0.0.1:8080/'],
            'private 10/8' => ['http://10.0.0.5/'],
            'private 192.168' => ['https://192.168.1.1/admin'],
            'cgnat' => ['http://100.64.0.1/'],
            'ipv6 loopback' => ['http://[::1]/'],
            'ipv4-mapped ipv6' => ['http://[::ffff:127.0.0.1]/'],
            'unspecified' => ['http://0.0.0.0/'],
            'file scheme' => ['file:///etc/passwd'],
            'gopher scheme' => ['gopher://example.com/'],
            'credentials in url' => ['http://user:pass@93.184.215.14/'],
            'non-web port' => ['http://93.184.215.14:6379/'],
        ];
    }

    #[DataProvider('blockedUrls')]
    public function test_it_rejects_non_public_targets(string $url): void
    {
        $this->expectException(InvalidArgumentException::class);

        SafeUrlFetcher::resolvePublicTarget($url);
    }

    public function test_it_accepts_a_public_ip_literal(): void
    {
        [$host, $port, $ips] = SafeUrlFetcher::resolvePublicTarget('https://93.184.215.14/specs');

        $this->assertSame('93.184.215.14', $host);
        $this->assertSame(443, $port);
        $this->assertSame(['93.184.215.14'], $ips);
    }
}
