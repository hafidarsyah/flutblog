<?php

namespace App\Http\Controllers;

use App\Models\Post;
use Illuminate\Http\Request;

class PostController extends Controller
{
    // get all posts
    public function index()
    {
        return Post::all();
    }

    // create post
    public function store()
    {
        request()->validate([
            'title' => 'required',
            'description' => 'required'
        ]);


        return Post::create([
            'title' => request('title'),
            'description' => request('description')
        ]);
    }

    // update post
    public function update(Post $post)
    {
        request()->validate([
            'title' => 'required',
            'description' => 'required'
        ]);


        $post->update([
            'title' => request('title'),
            'description' => request('description')
        ]);
    }

    // delete post
    public function destroy(Post $post)
    {
        $post->delete();
    }
}
