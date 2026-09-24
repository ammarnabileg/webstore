<?php

namespace Tests\Unit;

use App\Http\Controllers\WhatsAppAuthController;
use App\Services\EvolutionApiService;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;
use ReflectionMethod;

class WhatsAppPhoneFormatTest extends TestCase
{
    public static function phones(): array
    {
        return [
            'local kuwaiti number gets 965' => ['55512345', '96555512345'],
            'already international' => ['96555512345', '96555512345'],
            'plus and spaces' => ['+965 5551 2345', '96555512345'],
            '00 prefix' => ['0096555512345', '96555512345'],
            'too short' => ['12345', null],
            'letters only' => ['abc', null],
            'too long' => ['1234567890123456', null],
        ];
    }

    #[DataProvider('phones')]
    public function test_format_phone_number(string $input, ?string $expected): void
    {
        $controller = new WhatsAppAuthController($this->createMock(EvolutionApiService::class));
        $method = new ReflectionMethod($controller, 'formatPhoneNumber');

        $this->assertSame($expected, $method->invoke($controller, $input));
    }
}
