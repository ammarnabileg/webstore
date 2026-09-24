<?php

namespace Botble\AIAssistant\Http\Controllers;

use Botble\Base\Http\Controllers\BaseController;
use Botble\Base\Http\Responses\BaseHttpResponse;
use Botble\AIAssistant\Services\OpenRouterService;
use Illuminate\Http\Request;
use Exception;

class AIAssistantController extends BaseController
{
    public function __construct(protected OpenRouterService $aiService)
    {
    }

    public function generate(Request $request): BaseHttpResponse
    {
        $prompt = $request->input('prompt');
        $context = $request->input('context', '');

        try {
            $response = $this->aiService->chat($prompt, "You are a helpful Botble CMS assistant. Context: $context. Please provide a concise response. If generating content for a product or category, return ONLY the content text without any quotes or phrases like 'Here is your content'.");

            return $this
                ->httpResponse()
                ->setData(['content' => $response]);
        } catch (Exception $exception) {
            return $this
                ->httpResponse()
                ->setError()
                ->setMessage($exception->getMessage());
        }
    }

    public function settings()
    {
        $this->pageTitle('AI Assistant Settings');

        return view('plugins/ai-assistant::settings');
    }

    public function updateSettings(Request $request, BaseHttpResponse $response)
    {
        // Allowlist: this form must not be able to overwrite unrelated settings.
        $settings = $request->only(['ai_assistant_openrouter_api_key', 'ai_assistant_openrouter_model']);

        foreach ($settings as $key => $value) {
            setting()->set($key, (string)$value);
        }

        setting()->save();

        return $response
            ->setNextUrl(route('ai-assistant.settings'))
            ->setMessage(trans('core/base::notices.update_success_message'));
    }
}
