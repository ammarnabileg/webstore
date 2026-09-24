<?php

namespace App\Http\Controllers;

use App\Services\AiProductSpecsGeneratorService;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

class GenerateAiSpecsController extends Controller
{
    protected AiProductSpecsGeneratorService $aiSpecsService;

    public function __construct(AiProductSpecsGeneratorService $aiSpecsService)
    {
        $this->aiSpecsService = $aiSpecsService;
    }

    public function generate(Request $request)
    {
        $request->validate([
            'source_url' => 'nullable|url',
            'existing_description' => 'nullable|string',
        ]);

        try {
            $sourceUrl = $request->input('source_url');
            $existingDescription = $request->input('existing_description');

            if (empty($sourceUrl) && empty(strip_tags($existingDescription))) {
                return response()->json(['error' => 'Please provide a Source URL or write some product description first.'], 422);
            }

            $aiData = $this->aiSpecsService->generateSpecs($sourceUrl, $existingDescription);

            return response()->json([
                'success' => true,
                'data' => $aiData
            ]);
            
        } catch (\Exception $e) {
            $statusCode = $e->getCode();
            if ($statusCode < 100 || $statusCode > 599) {
                $statusCode = 500;
            }
            return response()->json(['error' => $e->getMessage()], $statusCode);
        }
    }
}
