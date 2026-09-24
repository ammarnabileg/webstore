<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Throwable;

class EvolutionApiService
{
    protected ?string $baseUrl;

    protected ?string $instanceName;

    protected ?string $apiKey;

    protected int $timeout;

    public function __construct()
    {
        $this->baseUrl = rtrim((string) config('services.evolution.url'), '/') ?: null;
        $this->instanceName = config('services.evolution.instance');
        $this->apiKey = config('services.evolution.key');
        $this->timeout = (int) config('services.evolution.timeout', 15);
    }

    public function isConfigured(): bool
    {
        return $this->baseUrl && $this->instanceName && $this->apiKey;
    }

    /**
     * Send a text message via WhatsApp
     *
     * @param string $phone Phone number in international format without '+' (e.g. 96512345678)
     * @param string $text The message text
     * @return bool|array
     */
    public function sendMessage($phone, $text)
    {
        if (! $this->isConfigured()) {
            Log::error('Evolution API is not configured (EVOLUTION_API_URL / EVOLUTION_INSTANCE_NAME / EVOLUTION_API_KEY).');

            return false;
        }

        // Add WhatsApp suffix if missing
        if (! str_contains($phone, '@s.whatsapp.net')) {
            $phone = preg_replace('/[^0-9]/', '', $phone) . '@s.whatsapp.net';
        }

        try {
            $response = Http::timeout($this->timeout)->withHeaders([
                'apikey' => $this->apiKey,
                'Content-Type' => 'application/json',
            ])->post("{$this->baseUrl}/message/sendText/{$this->instanceName}", [
                'number' => $phone,
                'text' => $text,
                'delay' => 1200,
                'presence' => 'composing',
            ]);

            if ($response->successful()) {
                return $response->json();
            }

            Log::error('Evolution API Send Message Error', ['status' => $response->status()]);

            return false;
        } catch (Throwable $e) {
            Log::error('Evolution API Exception', ['message' => $e->getMessage()]);

            return false;
        }
    }
}
