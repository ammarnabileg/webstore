<?php

namespace Botble\SystemWizard\Http\Controllers;

use Botble\Base\Http\Controllers\BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SystemWizardEventController extends BaseController
{
    public function store(Request $request)
    {
        $request->validate([
            'session_id' => 'required|string|max:100',
            'step' => 'required|string|max:50',
            'action' => 'required|string|max:100',
        ]);

        DB::table('sw_wizard_events')->insert([
            'session_id' => $request->input('session_id'),
            'step' => $request->input('step'),
            'action' => $request->input('action'),
            'payload' => $request->has('payload') ? json_encode($request->input('payload')) : null,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        return response()->json(['success' => true]);
    }
}
