<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\PostController;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Public routes


Route::post('/register', [AuthController::class, 'register']);

// Get app post
Route::get('/posts', [PostController::class, 'index']);

// Protected routes
Route::group(['middleware' => ['auth:sanctum']], function () {
    // Create Update Delete action post
    Route::post('/posts', [PostController::class, 'store']);
    Route::put('/posts/{post}', [PostController::class, 'update']);
    Route::delete('/posts/{post}', [PostController::class, 'destroy']);
});

// Default
Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
