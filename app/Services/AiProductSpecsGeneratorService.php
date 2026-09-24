<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use App\Support\SafeUrlFetcher;

class AiProductSpecsGeneratorService
{
    public function generateSpecs(?string $sourceUrl, ?string $existingDescription): array
    {
        if (empty($sourceUrl) && empty(strip_tags($existingDescription))) {
            throw new \Exception("Please provide a Source URL or existing description to extract specs from.", 422);
        }

        $outputLanguage = config('services.ai.output_language', 'ar');

        $fetchedPageText = 'Not Available';
        if ($sourceUrl) {
            try {
                $response = SafeUrlFetcher::get($sourceUrl, 10);


                if ($response->successful()) {
                    // Extract text, limiting to 5000 chars to avoid token explosion but capture enough specs
                    $html = strip_tags($response->body());
                    $fetchedPageText = mb_substr(preg_replace('/\s+/', ' ', $html), 0, 5000);
                }
            } catch (\InvalidArgumentException $e) {
                throw new \Exception($e->getMessage(), 422);
            } catch (\Exception $e) {
                throw new \Exception("Failed to fetch the Source URL. Ensure the URL is accessible.", 422);
            }
        }

        $prompt = "SYSTEM:
You are a highly skilled Technical Data Extractor for an electronics e-commerce store.

HARD RULES:
1. SOURCE-ONLY: Extract specifications ONLY from the provided SOURCE MATERIAL. Do not invent facts.
2. Return ONLY a strict JSON object. No markdown, no conversational text.
3. Language for output: {$outputLanguage}. Translate technical terms accurately to {$outputLanguage}, but keep universally known terms (like Mesh, Wi-Fi, Mbps, GHz, GB) in English or standard transliteration.

OUTPUT SCHEMA (exact keys, nothing else):
{
  \"specs\": [
    { \"name\": \"Attribute Name\", \"value\": \"Value\" }
  ]
}

USER:
SOURCE MATERIAL
---
URL CONTENT EXTRACT: {$fetchedPageText}
EXISTING DESCRIPTION: " . mb_substr(strip_tags($existingDescription ?? ''), 0, 3000) . "
---
Generate the JSON now.";

        $apiKey = config('services.ai.key');
        $baseUrl = config('services.ai.base_url');
        $model = config('services.ai.model');

        if (empty($apiKey)) {
            throw new \Exception("API Key is missing. Please set AI_API_KEY or OPENROUTER_API_KEY in .env file.", 422);
        }

        $payload = [
            'model' => $model,
            'messages' => [
                ['role' => 'user', 'content' => $prompt]
            ],
            'temperature' => 0.1, // Lower temperature for extremely strict JSON
            'max_tokens' => 4000, // Increased massively for long Arabic translations
            'response_format' => ['type' => 'json_object']
        ];

        $response = Http::withToken($apiKey)
            ->withHeaders([
                'HTTP-Referer' => config('app.url'),
                'X-Title' => 'Botble Specs AI Extractor'
            ])
            ->timeout(180) 
            ->post($baseUrl, $payload);

        if ($response->failed()) {
            Log::channel('ai_seo')->error('OpenRouter API Failed (Specs)', [
                'status' => $response->status(),
                'body' => $response->body()
            ]);
            throw new \Exception("AI provider request failed (HTTP {$response->status()}).", 500);
        }

        $responseData = $response->json();
        $rawOutput = $responseData['choices'][0]['message']['content'] ?? '';
        $tokens = $responseData['usage'] ?? [];

        $decoded = json_decode($rawOutput, true);
        if (!$decoded) {
            $rawOutputCleaned = preg_replace('/```json|```/', '', $rawOutput);
            $decoded = json_decode(trim($rawOutputCleaned), true);
            
            if (!$decoded) {
                // Log and throw the actual raw output so the user can see what the AI messed up
                Log::channel('ai_seo')->error('Invalid JSON (Specs)', ['output' => $rawOutput]);
                throw new \Exception("Failed to generate valid JSON. Raw Output: " . mb_substr($rawOutput, 0, 100), 422);
            }
        }

        if (!isset($decoded['specs']) || !is_array($decoded['specs'])) {
            throw new \Exception("Missing 'specs' array in AI response.", 422);
        }

        // Build HTML table from the JSON array
        $htmlTable = '<table class="table table-bordered table-striped" style="width: 100%; border-collapse: collapse;"><tbody>';
        foreach ($decoded['specs'] as $spec) {
            $name = htmlspecialchars($spec['name'] ?? '');
            $value = htmlspecialchars($spec['value'] ?? '');
            if ($name && $value) {
                $htmlTable .= "<tr><th style='width: 30%; padding: 8px; border: 1px solid #ddd; background-color: #f8f9fa;'>{$name}</th><td style='padding: 8px; border: 1px solid #ddd;'>{$value}</td></tr>";
            }
        }
        $htmlTable .= '</tbody></table>';

        $decoded['specs_html'] = $htmlTable;

        Log::channel('ai_seo')->info('AI Specs Generation', [
            'model' => $model,
            'tokens' => $tokens,
            'timestamp' => now()->toDateTimeString(),
        ]);

        return $decoded;
    }
}
