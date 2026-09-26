<?php

namespace Tests\Unit;

use Botble\Base\Supports\EmailHandler;
use PHPUnit\Framework\TestCase;

class EmailTwigNeutralizeTest extends TestCase
{
    public static function payloads(): array
    {
        return [
            'print' => ['{{ ["id"]|map("system")|join }}'],
            'block' => ['{% set f %}system{% endset %}'],
            'comment' => ['{# x #}'],
            'split across value' => ['{{{{'],
        ];
    }

    #[\PHPUnit\Framework\Attributes\DataProvider('payloads')]
    public function test_no_twig_delimiter_survives(string $payload): void
    {
        $out = EmailHandler::neutralizeTwig($payload);

        $this->assertDoesNotMatchRegularExpression('/\{[{%#]/', $out);
        $this->assertSame($payload, str_replace("\u{200B}", '', $out));
    }

    public function test_plain_text_is_untouched(): void
    {
        $this->assertSame('Ahmed {Ali} 50%', EmailHandler::neutralizeTwig('Ahmed {Ali} 50%'));
    }

    public function test_twig_cannot_parse_neutralized_value(): void
    {
        $twig = new \Twig\Environment(new \Twig\Loader\ArrayLoader([
            't' => EmailHandler::neutralizeTwig('{{ 7*7 }}{% if true %}X{% endif %}'),
        ]));

        $this->assertStringNotContainsString('49', $twig->render('t'));
        $this->assertStringNotContainsString("\u{200B}X", $twig->render('t'));
    }
}
