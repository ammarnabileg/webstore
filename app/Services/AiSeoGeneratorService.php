<?php

namespace App\Services;

use Botble\Ecommerce\Models\Product;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class AiSeoGeneratorService
{
    const PROMPT_VERSION = 1;

    public function generateForProduct(Product $product, ?string $sourceUrl = null): array
    {
        $existingDescription = strip_tags($product->description ?? '');
        $existingContent = strip_tags($product->content ?? '');
        
        $descToUse = $existingDescription ?: $existingContent;

        if (empty($descToUse) || mb_strlen($descToUse) < 100) {
            // Check if there are spec tables in HTML before rejecting?
            // User requested: "لو existing_description فاضي أو أقل من 100 حرف ومفيش بيانات specification tables"
            $hasSpecTable = false;
            if (str_contains($product->description ?? '', '<table') || str_contains($product->content ?? '', '<table') || str_contains($product->content ?? '', 'specs-table')) {
                $hasSpecTable = true;
            }

            if (!$hasSpecTable) {
                throw new \Exception("Please add a product description or specification table first before generating SEO.", 422);
            }
        }

        $brandName = theme_option('site_title') ?: env('APP_NAME', 'Laly Kuwait');
        $outputLanguage = env('AI_OUTPUT_LANGUAGE', 'ar');

        $fetchedPageText = 'Not Available';
        if ($sourceUrl) {
            // Simple fetch logic for v1.1
            try {
                $response = Http::timeout(5)->get($sourceUrl);
                if ($response->successful()) {
                    // Very simple extraction for now, limiting to 1000 chars to avoid token explosion
                    $html = strip_tags($response->body());
                    $fetchedPageText = substr(preg_replace('/\s+/', ' ', $html), 0, 1000);
                }
            } catch (\Exception $e) {
                // Ignore fetch errors
            }
        }

        // Prepare attributes
        $attributesText = '';
        if (method_exists($product, 'productAttributeSets')) {
            // Depending on Botble Ecommerce version
            $attributesText = 'Attributes available in product model';
        }

        $prompt = "SYSTEM:
You are an e-commerce SEO copywriter for {$brandName}, an electronics store in Kuwait.

HARD RULES — violating any rule makes the output unusable:
1. SOURCE-ONLY: use only facts present in the SOURCE MATERIAL. Never add specs,
   features, dimensions, compatibility, certifications, warranty, or prices
   that are not explicitly stated there.
2. If the source material is insufficient for a field, return null for that
   field. Never fill gaps from general knowledge.
3. Do not copy sentences verbatim from the source; rewrite in your own words.
4. Output raw JSON only — no markdown fences, no text before or after.
5. All output values in: {$outputLanguage}.
6. Keep technical terms like (Mesh, Wi-Fi, etc) in English or transliterate them correctly (e.g., use 'ميش' instead of 'ميس' for Mesh).

OUTPUT SCHEMA (exact keys, nothing else):
{
  \"seo_title\": \"max 60 chars, must include the model code if present,
                format: <product> <model> | {$brandName}\",
  \"seo_description\": \"100–140 chars, one clear benefit + one concrete spec,
                      plain call to action at the end\",
  \"focus_keyword\": \"the main term a buyer in Kuwait would actually search\"
}

STYLE: professional, benefit-led. FORBIDDEN: emojis, exclamation marks,
urgency/scarcity wording, superlatives without a stated basis.

USER:
SOURCE MATERIAL
---
PRODUCT NAME: {$product->name}
BRAND: " . ($product->brand ? $product->brand->name : 'Not Available') . "
CATEGORY: " . ($product->categories->first() ? $product->categories->first()->name : 'Not Available') . "
ATTRIBUTES: {$attributesText}
EXISTING DESCRIPTION: {$descToUse}
MANUFACTURER PAGE EXTRACT: {$fetchedPageText}
MANAGER NOTES (verified local facts — warranty, delivery): Not Available
---
Generate the JSON now.";

        $apiKey = env('AI_API_KEY') ?: env('OPENROUTER_API_KEY');
        $baseUrl = env('AI_BASE_URL', 'https://openrouter.ai/api/v1/chat/completions');
        $model = env('AI_MODEL') ?: env('OPENROUTER_MODEL', 'qwen/qwen3-235b-a22b'); // We will append /no_think below if using openrouter

        if (empty($apiKey)) {
            throw new \Exception("API Key is missing. Please set AI_API_KEY or OPENROUTER_API_KEY in .env file.", 422);
        }

        if (strpos($baseUrl, 'openrouter') !== false && !str_ends_with($model, ':free') && !str_ends_with($model, '/no_think')) {
            // Append no_think for OpenRouter to disable reasoning
            // Actually OpenRouter supports passing include_reasoning: false
            $includeReasoning = false;
        }

        $payload = [
            'model' => $model,
            'messages' => [
                ['role' => 'user', 'content' => $prompt]
            ],
            'temperature' => 0.3,
            'max_tokens' => 300,
        ];
        
        // OpenRouter or compatible response format
        $payload['response_format'] = ['type' => 'json_object'];

        if (isset($includeReasoning)) {
            $payload['include_reasoning'] = false;
        }

        $apiCall = function() use ($baseUrl, $apiKey, $payload) {
            $response = Http::withToken($apiKey)
                ->withHeaders([
                    'HTTP-Referer' => config('app.url'),
                    'X-Title' => 'Botble SEO AI Generator'
                ])
                ->timeout(30)
                ->post($baseUrl, $payload);
                
            if ($response->failed()) {
                Log::channel('ai_seo')->error('OpenRouter API Failed', [
                    'status' => $response->status(),
                    'body' => $response->body()
                ]);
                throw new \Exception("API Error: " . $response->body(), 500);
            }
            
            return $response;
        };

        $response = $apiCall();
        $responseData = $response->json();

        $rawOutput = $responseData['choices'][0]['message']['content'] ?? '';
        $tokens = $responseData['usage'] ?? [];

        // 1. json_decode; on failure -> retry ONCE
        $decoded = json_decode($rawOutput, true);
        if (!$decoded) {
            // Retry ONCE
            $response = $apiCall();
            $responseData = $response->json();
            $rawOutput = $responseData['choices'][0]['message']['content'] ?? '';
            $tokens = $responseData['usage'] ?? [];
            $decoded = json_decode($rawOutput, true);

            if (!$decoded) {
                // Remove markdown fences if model ignored rule 4
                $rawOutputCleaned = preg_replace('/```json|```/', '', $rawOutput);
                $decoded = json_decode(trim($rawOutputCleaned), true);
                if (!$decoded) {
                    $this->logActivity($product->id, $model, $prompt, $rawOutput, $tokens);
                    throw new \Exception("Failed to generate valid JSON after 2 attempts. Raw output: " . substr($rawOutput, 0, 100), 422);
                }
            }
        }

        $this->logActivity($product->id, $model, $prompt, $rawOutput, $tokens);

        // 2. assert keys exist
        if (!isset($decoded['seo_title']) || !isset($decoded['seo_description']) || !isset($decoded['focus_keyword'])) {
            throw new \Exception("Missing required keys in AI response.", 422);
        }

        // 3. strip emojis + control chars
        $decoded['seo_title'] = $this->cleanString($decoded['seo_title']);
        $decoded['seo_description'] = $this->cleanString($decoded['seo_description']);
        $decoded['focus_keyword'] = $this->cleanString($decoded['focus_keyword']);

        // 4. clamp lengths server-side at word boundary
        $decoded['seo_title'] = $this->clampString($decoded['seo_title'], 60);
        $decoded['seo_description'] = $this->clampString($decoded['seo_description'], 160);

        // 5. reject if output language != AI_OUTPUT_LANGUAGE (basic heuristic as requested)
        if ($outputLanguage === 'en') {
            if ($this->hasTooMuchArabic($decoded['seo_title'] . $decoded['seo_description'])) {
                throw new \Exception("AI generated Arabic text instead of English.", 422);
            }
        } elseif ($outputLanguage === 'ar') {
            if ($this->hasTooMuchArabic($decoded['seo_title'] . $decoded['seo_description']) === false) { // false means it's mostly english
                throw new \Exception("AI generated English text instead of Arabic.", 422);
            }
        }

        return $decoded;
    }

    private function cleanString($string)
    {
        if (!$string) return '';
        // Strip emojis and control chars
        $string = preg_replace('/[\x00-\x1F\x7F]/u', '', $string);
        // Basic emoji strip
        $string = preg_replace('/[\x{1F600}-\x{1F64F}]/u', '', $string);
        $string = preg_replace('/[\x{1F300}-\x{1F5FF}]/u', '', $string);
        $string = preg_replace('/[\x{1F680}-\x{1F6FF}]/u', '', $string);
        $string = preg_replace('/[\x{2600}-\x{26FF}]/u', '', $string);
        $string = preg_replace('/[\x{2700}-\x{27BF}]/u', '', $string);
        return trim($string);
    }

    private function clampString($string, $maxLength)
    {
        if (!$string || mb_strlen($string) <= $maxLength) return $string;

        $string = mb_substr($string, 0, $maxLength);
        // Find last space to clamp at word boundary
        $lastSpace = mb_strrpos($string, ' ');
        if ($lastSpace !== false) {
            $string = mb_substr($string, 0, $lastSpace);
        }
        return $string;
    }

    private function hasTooMuchArabic($string)
    {
        $totalLength = mb_strlen($string);
        if ($totalLength === 0) return false;

        $arabicChars = preg_match_all('/[\x{0600}-\x{06FF}]/u', $string);
        $ratio = $arabicChars / $totalLength;

        // If ratio > 0.20, we consider it contains significant Arabic
        return $ratio > 0.20;
    }

    private function logActivity($productId, $model, $prompt, $rawOutput, $tokens)
    {
        Log::channel('ai_seo')->info('AI SEO Generation', [
            'product_id' => $productId,
            'model' => $model,
            'prompt_hash' => md5($prompt),
            'prompt_version' => self::PROMPT_VERSION,
            'raw_output' => $rawOutput,
            'tokens' => $tokens,
            'timestamp' => now()->toDateTimeString(),
        ]);
    }
}
