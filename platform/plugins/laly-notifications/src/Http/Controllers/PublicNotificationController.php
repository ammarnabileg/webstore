<?php

namespace Botble\LalyNotifications\Http\Controllers;

use Botble\LalyNotifications\Models\CustomerFcmToken;
use Botble\LalyNotifications\Models\Notification;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

class PublicNotificationController extends Controller
{
    public function index(): JsonResponse
    {
        $isLoggedIn = auth('customer')->check();

        $notifications = Notification::query()
            ->whereIn('status', ['published', 'scheduled'])
            ->where(fn ($q) => $q->whereNull('scheduled_at')->orWhere('scheduled_at', '<=', now()))
            ->whereIn('type', $isLoggedIn ? ['all', 'logged_in'] : ['all', 'guest'])
            ->with(['category.slugable', 'collection'])
            ->orderByDesc('created_at')
            ->limit(50)
            ->get()
            ->map(fn (Notification $item) => [
                'id' => $item->id,
                'title' => $item->title,
                'description' => $item->description,
                'target_url' => $item->target_url,
                'created_at' => $item->created_at ? $item->created_at->diffForHumans() : '',
            ]);

        return response()->json(['data' => $notifications, 'is_logged_in' => $isLoggedIn]);
    }

    public function storeToken(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'token' => ['required', 'string', 'max:512'],
            'device_type' => ['nullable', 'in:web,ios,android'],
        ]);

        $fcmToken = CustomerFcmToken::query()->firstOrNew(['token' => $validated['token']]);

        // A guest request must not detach a token from the customer it belongs to.
        if (auth('customer')->check()) {
            $fcmToken->customer_id = auth('customer')->id();
        }

        $fcmToken->device_type = $validated['device_type'] ?? 'web';
        $fcmToken->save();

        return response()->json(['success' => true]);
    }
}
