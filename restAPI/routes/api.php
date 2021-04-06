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

// Auth
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// Get app post
Route::get('/posts', [PostController::class, 'index']);
Route::get('/posts/{title}', [PostController::class, 'search']);
Route::get('/post/{id}', [PostController::class, 'find']);
Route::get('/my_post/{id}', [PostController::class, 'myPost']);

// Protected routes
Route::group(['middleware' => ['auth:sanctum']], function () {
    // Create Update Delete action post
    Route::post('/posts', [PostController::class, 'store']);
    Route::put('/posts/{post}', [PostController::class, 'update']);
    Route::delete('/posts/{post}', [PostController::class, 'destroy']);
    // Logout
    Route::post('/logout', [AuthController::class, 'logout']);
});

// Default
Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
