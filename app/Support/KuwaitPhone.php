<?php

namespace App\Support;

/**
 * One phone format for the whole store: international digits without "+" (965XXXXXXXX).
 * Customers type numbers in any shape; WhatsApp (Evolution) needs the country code.
 */
class KuwaitPhone
{
    public static function normalize(?string $phone): ?string
    {
        $digits = preg_replace('/\D/', '', (string) $phone);
        $digits = preg_replace('/^00/', '', $digits);

        // Local Kuwaiti numbers have 8 digits and no country code.
        if (strlen($digits) === 8) {
            $digits = '965' . $digits;
        }

        return preg_match('/^[1-9]\d{7,14}$/', $digits) ? $digits : null;
    }

    /**
     * Kuwaiti landline or mobile (first local digit 1, 2, 4, 5, 6 or 9).
     */
    public static function isKuwaiti(?string $normalized): bool
    {
        return (bool) preg_match('/^965[124569]\d{7}$/', (string) $normalized);
    }
}
