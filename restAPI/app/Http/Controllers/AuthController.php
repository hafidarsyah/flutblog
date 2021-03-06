<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function register()
    {
        request()->validate([
            'name' => 'required|string',
            'email' => 'required|string|unique:users,email',
            'password' => 'required|string|confirmed'
        ]);

        $user = User::create([
            'name' => request('name'),
            'email' => request('email'),
            'password' => bcrypt(request('password'))
        ]);

        $token = $user->createToken('myapptoken')->plainTextToken;

        $response = [
            'user' => $user,
            'token' => $token
        ];

        return response($response, 201);
    }

    public function login()
    {
        request()->validate([
            'email' => 'required|string',
            'password' => 'required|string'
        ]);

        // Check email
        $user = User::where('email', request('email'))->first();

        // Check password
        if (!$user || !Hash::check(request('password'), $user->password)) {
            return response(401);
        }

        $token = $user->createToken('myapptoken')->plainTextToken;

        $response = [
            'user' => $user,
            'token' => $token
        ];

        return response($response, 201);
    }

    public function logout()
    {
        auth()->user()->tokens()->delete();

        return response(201);
    }
}
