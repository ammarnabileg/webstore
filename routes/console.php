<?php

use Illuminate\Support\Facades\Schedule;

// Queue worker for hosts without supervisor: the cron that runs `schedule:run` every minute
// drains the database queue (order WhatsApp messages, broadcasts, push notifications).
Schedule::command('queue:work --stop-when-empty --max-time=55 --tries=3')
    ->everyMinute()
    ->withoutOverlapping(10);
