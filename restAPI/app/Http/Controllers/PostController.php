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

    public function find($id)
    {
        return Post::where('id', $id)->get();
    }

    public function search($title)
    {
        return Post::where('title', 'like', '%' . $title . '%')->get();
    }

    // create post
    public function store()
    {
        request()->validate([
            'user_id' => 'required',
            'title' => 'required',
            'description' => 'required'
        ]);

        return Post::create([
            'user_id' => request('user_id'),
            'title' => request('title'),
            'description' => request('description')
        ]);
    }

    // update post
    public function update(Post $post)
    {
        request()->validate([
            'user_id' => 'required',
            'title' => 'required',
            'description' => 'required'
        ]);

        $post->update([
            'user_id' => request('user_id'),
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
