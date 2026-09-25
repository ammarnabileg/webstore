<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * The data-synchronize importer (vendor/botble/data-synchronize) uses a client-supplied
 * `file_name` to read/move/delete files under storage/app, validating it only as a string.
 * A traversal value such as "../public/x.csv" (with a large offset) lets an importer user —
 * including a self-service marketplace vendor — move or delete out-of-scope spreadsheet files.
 *
 * That fix lives in a Composer package we cannot edit without it being overwritten, so this
 * app-side guard rejects any request whose `file_name` is not a bare filename. A legitimate
 * import file_name is always a basename (the uploader stores it under a server-generated name),
 * so this has effectively no false positives.
 */
class BlockFileNameTraversal
{
    public function handle(Request $request, Closure $next): Response
    {
        $fileName = $request->input('file_name');

        if (is_string($fileName) && $fileName !== '' && (
            $fileName !== basename($fileName)
            || str_contains($fileName, '..')
        )) {
            abort(422, 'Invalid file name.');
        }

        return $next($request);
    }
}
