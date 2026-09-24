<?php

namespace Botble\Deema\Http\Controllers;

use Botble\Base\Http\Controllers\BaseController;
use Botble\Base\Http\Responses\BaseHttpResponse;
use Botble\Ecommerce\Models\Order;
use Botble\Payment\Supports\PaymentHelper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class DeemaController extends BaseController
{
    /**
     * Customer returns from Deema. Query parameters are user-controlled (anyone can open
     * ?status=success&order_id=123), so this page never marks an order as paid.
     */
    public function getCallback(Request $request, BaseHttpResponse $response)
    {
        // Looked up by the unguessable checkout token from our own return URL (never the id).
        $order = $request->filled('t') ? Order::query()->where('token', (string) $request->input('t'))->first() : null;
        $token = $order?->token;

        if (! $order || $request->input('status') !== 'success') {
            return $response
                ->setError()
                ->setNextUrl(PaymentHelper::getCancelURL($token))
                ->setMessage(__('Payment failed or cancelled!'));
        }

        return $response
            ->setNextUrl(PaymentHelper::getRedirectURL($token))
            ->setMessage(__('Your payment is being confirmed. You will be notified once it is approved.'));
    }

    /**
     * Deema payment notifications.
     *
     * This endpoint used to mark any order as paid from an unauthenticated POST
     * (order_id + status=captured). Until Deema's webhook signature scheme is implemented,
     * notifications are only recorded and payments are confirmed by an admin after checking
     * the Deema merchant dashboard.
     */
    public function postWebhook(Request $request)
    {
        Log::info('Deema webhook received (not auto-processed: signature verification not configured)', [
            'order_id' => $request->input('order_id') ?? $request->input('merchant_order_id'),
            'status' => $request->input('status'),
        ]);

        return response()->json(['status' => 'received'], 202);
    }
}
