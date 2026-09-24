<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class EvolutionApiService
{
    protected $baseUrl;
    protected $instanceName;
    protected $apiKey;

    public function __construct()
    {
        $this->baseUrl = rtrim(env('EVOLUTION_API_URL', 'https://web.hahireai.com'), '/');
        $this->instanceName = env('EVOLUTION_INSTANCE_NAME', 'e5d77360-7119-45f0-ac09-ca0c1e0bd3d7'); // User's instance string or name
        $this->apiKey = env('EVOLUTION_API_KEY', '94AD7AEA908A-4037-8CBF-6F59E3F08616');
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
        // Add WhatsApp suffix if missing
        if (!str_contains($phone, '@s.whatsapp.net')) {
            $phone = preg_replace('/[^0-9]/', '', $phone) . '@s.whatsapp.net';
        }

        try {
            $response = Http::withoutVerifying()->withHeaders([
                'apikey' => $this->apiKey,
                'Content-Type' => 'application/json',
            ])->post("{$this->baseUrl}/message/sendText/{$this->instanceName}", [
                'number' => $phone,
                'text' => $text,
                'delay' => 1200,
                'presence' => 'composing'
            ]);

            if ($response->successful()) {
                return $response->json();
            }

            Log::error('Evolution API Send Message Error', ['response' => $response->body()]);
            return false;
        } catch (\Exception $e) {
            Log::error('Evolution API Exception', ['message' => $e->getMessage()]);
            return false;
        }
    }
}
