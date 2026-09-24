<?php

namespace App\Http\Controllers;

use App\Services\AiSeoGeneratorService;
use Botble\Ecommerce\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

class GenerateAiSeoController extends Controller
{
    protected AiSeoGeneratorService $aiSeoGeneratorService;

    public function __construct(AiSeoGeneratorService $aiSeoGeneratorService)
    {
        $this->aiSeoGeneratorService = $aiSeoGeneratorService;
    }

    public function generate(Request $request)
    {
        $request->validate([
            'product_id' => 'required|integer',
            'source_url' => 'nullable|url',
        ]);

        $product = Product::findOrFail($request->product_id);

        try {
            $data = $this->aiSeoGeneratorService->generateForProduct($product, $request->input('source_url'));
            return response()->json($data);
        } catch (\Exception $e) {
            $statusCode = $e->getCode() === 422 ? 422 : 500;
            return response()->json([
                'error' => true,
                'message' => $e->getMessage()
            ], $statusCode);
        }
    }
}
