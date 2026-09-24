<?php

namespace Botble\Ecommerce\Models;

use Botble\Base\Casts\SafeContent;
use Botble\Base\Models\BaseModel;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Notification extends BaseModel
{
    protected $table = 'ec_notifications';

    protected $fillable = [
        'title',
        'description',
        'type',
        'target_type',
        'target_id',
        'custom_url',
        'status',
        'scheduled_at',
    ];

    protected $casts = [
        'title' => SafeContent::class,
        'description' => SafeContent::class,
        'scheduled_at' => 'datetime',
    ];

    public function category(): BelongsTo
    {
        return $this->belongsTo(ProductCategory::class, 'target_id')->withDefault();
    }

    public function collection(): BelongsTo
    {
        return $this->belongsTo(ProductCollection::class, 'target_id')->withDefault();
    }

    public function getTargetUrlAttribute(): string
    {
        if ($this->target_type === 'custom_url' && $this->custom_url) {
            return $this->custom_url;
        }

        if ($this->target_type === 'category') {
            return ($this->category && $this->category->id) ? $this->category->url : route('public.products');
        }

        if ($this->target_type === 'collection') {
            return ($this->collection && $this->collection->id) ? $this->collection->url : route('public.products');
        }

        return route('public.products');
    }
}
