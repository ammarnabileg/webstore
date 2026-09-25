<?php

namespace Tests\Unit;

use App\Support\KuwaitPhone;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;

class KuwaitPhoneTest extends TestCase
{
    public static function phones(): array
    {
        return [
            'local mobile' => ['55512345', '96555512345'],
            'spaces' => ['5551 2345', '96555512345'],
            'plus, spaces, dash' => ['+965 5551-2345', '96555512345'],
            '00 prefix' => ['0096555512345', '96555512345'],
            'brackets' => ['(965) 55512345', '96555512345'],
            'foreign number kept' => ['+20 100 123 4567', '201001234567'],
            'too short' => ['12345', null],
            'letters' => ['abc', null],
            'empty' => ['', null],
        ];
    }

    #[DataProvider('phones')]
    public function test_normalize(string $input, ?string $expected): void
    {
        $this->assertSame($expected, KuwaitPhone::normalize($input));
    }

    public function test_is_kuwaiti(): void
    {
        $this->assertTrue(KuwaitPhone::isKuwaiti('96555512345'));
        $this->assertTrue(KuwaitPhone::isKuwaiti('96522212345'));
        $this->assertFalse(KuwaitPhone::isKuwaiti('96535512345'));
        $this->assertFalse(KuwaitPhone::isKuwaiti('201001234567'));
        $this->assertFalse(KuwaitPhone::isKuwaiti(null));
    }
}
