<?php
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;

Route::get('/health', function () {
    try {
        DB::connection()->getPdo();
        $db = 'ok';
        $status = 200;
    } catch (\Exception $e) {
        $db = 'error';
        $status = 500;
    }

    return response()->json([
        'status' => $status === 200 ? 'healthy' : 'unhealthy',
        'database' => $db,
        'timestamp' => now()->toIso8601String(),
    ], $status);
});

?>
