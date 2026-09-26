<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class WhatsAppBroadcastRecipient extends Model
{
    protected $table = 'whatsapp_broadcast_recipients';

    protected $fillable = ['broadcast_id', 'customer_id', 'phone', 'status'];
}
