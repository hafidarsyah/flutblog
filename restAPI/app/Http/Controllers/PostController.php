<?php

namespace App\Http\Controllers;

use App\Models\Post;
use Illuminate\Http\Request;

class PostController extends Controller
{
    // get all post
    public function index()
    {
        return Post::all();
    }

    // create post
    public function store()
    {
        request()->validate([
            'title' => 'required',
            'content' => 'required'
        ]);


        return Post::create([
            'title' => request('title'),
            'content' => request('content')
        ]);
    }

    // update post
    public function update(Post $post)
    {
        request()->validate([
            'title' => 'required',
            'content' => 'required'
        ]);


        $success = $post->update([
            'title' => request('title'),
            'content' => request('content')
        ]);

        return [
            'success' => $success
        ];
    }

    // delete post
    public function destroy(Post $post)
    {
        $success = $post->delete();

        return [
            'success' => $success
        ];
    }
}
