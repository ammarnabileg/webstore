<?php

return [
    [
        'name' => 'اعرف نظامك',
        'flag' => 'plugin.system-wizard',
    ],
    [
        'name' => 'الطلبات الواردة',
        'flag' => 'system-wizard.index',
        'parent_flag' => 'plugin.system-wizard',
    ],
    [
        'name' => 'تحديث حالة الطلب',
        'flag' => 'system-wizard.edit',
        'parent_flag' => 'system-wizard.index',
    ],
    [
        'name' => 'إعدادات المنتجات',
        'flag' => 'system-wizard.settings',
        'parent_flag' => 'plugin.system-wizard',
    ],
];
