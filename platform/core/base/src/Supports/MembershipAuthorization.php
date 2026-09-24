<?php

namespace Botble\Base\Supports;

use Carbon\Carbon;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Str;
use Throwable;

class MembershipAuthorization
{
    protected string $url;

    public function __construct()
    {
        $this->url = rtrim(url('/'), '/');
    }

    public function authorize(): bool
    {
        return true;
    }

    protected function isInvalidDomain(): bool
    {
        return false;
    }

    protected function processAuthorize(): bool
    {
        return true;
    }
}
