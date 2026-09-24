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
        'answers' => 'json',
        'bom' => 'json',
    ];
}
