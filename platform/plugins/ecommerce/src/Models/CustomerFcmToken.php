<?php

namespace Botble\Ecommerce\Models;

use Botble\Base\Models\BaseModel;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class CustomerFcmToken extends BaseModel
{
    protected $table = 'ec_customer_fcm_tokens';

    protected $fillable = [
        'customer_id',
        'token',
        'device_type',
    ];

    public function customer(): BelongsTo
    {
        return $this->belongsTo(Customer::class, 'customer_id')->withDefault();
    }
}
