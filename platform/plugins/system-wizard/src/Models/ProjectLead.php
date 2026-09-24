<?php

namespace Botble\SystemWizard\Models;

use Botble\Base\Models\BaseModel;

class ProjectLead extends BaseModel
{
    protected $table = 'sw_project_leads';

    protected $fillable = [
        'name',
        'phone',
        'answers',
        'package_tier',
        'estimate',
        'bom',
        'status',
    ];

    protected $casts = [
        'answers' => 'array',
        'bom' => 'array',
        'estimate' => 'decimal:3',
    ];

    public const STATUSES = [
        'new' => 'جديد',
        'contacted' => 'تم التواصل',
        'surveyed' => 'تمت المعاينة',
        'quoted' => 'تم إرسال عرض السعر',
        'won' => 'تم التعاقد',
        'lost' => 'لم يتم',
    ];

    public const TIER_LABELS = [
        'basic' => 'الأساسية',
        'pro' => 'الاحترافية',
        'prem' => 'المميزة',
        'advise' => 'يحتاج ترشيحًا',
    ];

    /**
     * Leads saved before the double-encoding fix hold a JSON string inside the JSON column.
     */
    public function answersData(): array
    {
        return $this->decodeLegacy($this->answers);
    }

    public function bomData(): array
    {
        return $this->decodeLegacy($this->bom);
    }

    protected function decodeLegacy(mixed $value): array
    {
        if (is_string($value)) {
            $value = json_decode($value, true);
        }

        return is_array($value) ? $value : [];
    }
}
