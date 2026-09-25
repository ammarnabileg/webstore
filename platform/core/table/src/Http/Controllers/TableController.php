<?php

namespace Botble\Table\Http\Controllers;

use Botble\ACL\Models\User;
use Botble\Base\Http\Controllers\BaseController;
use Botble\Table\Abstracts\TableAbstract;
use Botble\Table\TableBuilder;
use Illuminate\Support\Facades\Auth;

class TableController extends BaseController
{
    public function __construct(protected TableBuilder $tableBuilder)
    {
    }

    /**
     * The bulk endpoints are shared by the admin panel and the marketplace vendor panel and take a
     * caller-chosen table class. Table permission checks fail OPEN for non-ACL-User principals (see
     * HasPermissions / TableAbstract::hasPermission), so a vendor (customer guard) hitting the vendor
     * bulk route could name an admin table (users, orders, ...) and bulk delete/edit it. A non-admin
     * principal may therefore only operate a table explicitly built for the vendor panel — marked by
     * the marketplace `ForVendor` trait — while admins keep going through the normal ACL check.
     */
    protected function abortIfBulkTableNotAllowed(TableAbstract $table): void
    {
        if (Auth::guard()->user() instanceof User) {
            return;
        }

        $isVendorTable = (bool) preg_grep('/\\\\ForVendor$/', class_uses_recursive($table));

        abort_unless($isVendorTable, 403);
    }
}
