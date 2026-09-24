<?php

namespace Botble\AIAssistant\Services;

use Illuminate\Support\Facades\Http;
use Exception;

class OpenRouterService
{
    public function chat(string $prompt, string $systemMessage = 'You are a helpful assistant for a Botble CMS admin.'): ?string
    {
        $apiKey = config('plugins.ai-assistant.general.openrouter_api_key') ?: setting('ai_assistant_openrouter_api_key');
        $model = config('plugins.ai-assistant.general.openrouter_model') ?: setting('ai_assistant_openrouter_model', 'openai/gpt-3.5-turbo');

        if (! $apiKey) {
            throw new Exception('OpenRouter API Key is not configured.');
        }

        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $apiKey,
            'HTTP-Referer' => url(''),
            'X-Title' => 'Botble AI Assistant',
        ])->withoutVerifying()
        ->timeout(120)
        ->post('https://openrouter.ai/api/v1/chat/completions', [
            'model' => $model,
            'messages' => [
                ['role' => 'system', 'content' => $systemMessage],
                ['role' => 'user', 'content' => $prompt],
            ],
        ]);

        if ($response->failed()) {
            $error = $response->json('error.message') ?: 'Failed to connect to OpenRouter.';
            throw new Exception($error);
        }

        return $response->json('choices.0.message.content');
    }
}
