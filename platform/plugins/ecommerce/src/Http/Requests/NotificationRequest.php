<?php

namespace Botble\Ecommerce\Http\Requests;

use Botble\Support\Http\Requests\Request;

class NotificationRequest extends Request
{
    public function rules(): array
    {
        return [
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'type' => 'required|in:all,guest,logged_in',
            'target_type' => 'required|in:none,category,collection,custom_url',
            'target_id_combined' => 'nullable|string',
            'custom_url' => 'nullable|url|max:255',
            'scheduled_at' => 'nullable|date',
            'status' => 'required|in:draft,scheduled,published',
        ];
    }
}
