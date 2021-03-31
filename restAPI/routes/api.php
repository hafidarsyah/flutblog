<?php

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

// Default
Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

// get all posts
Route::get('/posts', [PostController::class, 'index']);

// get post
Route::get('/post/{id}', [PostController::class, 'get']);

// create post
Route::post('/posts', [PostController::class, 'store']);

// update post
Route::put('/posts/{post}', [PostController::class, 'update']);

// delete post
Route::delete('/posts/{post}', [PostController::class, 'destroy']);
