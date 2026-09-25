<?php

return [
    [
        'name' => 'Push notifications',
        'flag' => 'laly-notifications.index',
    ],
    [
        'name' => 'Create',
        'flag' => 'laly-notifications.create',
        'parent_flag' => 'laly-notifications.index',
    ],
    [
        'name' => 'Edit',
        'flag' => 'laly-notifications.edit',
        'parent_flag' => 'laly-notifications.index',
    ],
    [
        'name' => 'Delete',
        'flag' => 'laly-notifications.destroy',
        'parent_flag' => 'laly-notifications.index',
    ],
    [
        'name' => 'Firebase settings',
        'flag' => 'laly-notifications.settings',
        'parent_flag' => 'laly-notifications.index',
    ],
];
