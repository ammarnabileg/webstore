<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class WhatsAppBroadcast extends Model
{
    protected $table = 'whatsapp_broadcasts';

    protected $fillable = ['message', 'status', 'total', 'sent', 'failed', 'created_by', 'finished_at'];

    protected $casts = [
        'finished_at' => 'datetime',
    ];

    public function recipients(): HasMany
    {
        return $this->hasMany(WhatsAppBroadcastRecipient::class, 'broadcast_id');
    }

    public function isRunning(): bool
    {
        return in_array($this->status, ['queued', 'sending'], true);
    }
}
