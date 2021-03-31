import 'package:http/http.dart' as client;

import '../models/post_model.dart';

class PostService {
  // Base URL API
  final String baseURL = 'http://127.0.0.1:8000';

  // Get all posts
  Future<List<PostModel>?> getPosts() async {
    var response = await client.get(Uri.parse(baseURL + '/api/posts'));

    if (response.statusCode == 200) return postFromJson(response.body);
    return null;
  }

  // Create post
  Future<bool> createPost(PostModel postModel) async {
    var response = await client.post(
      Uri.parse(baseURL + '/api/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: postToJson(postModel),
    );

    if (response.statusCode == 201) return true;
    return false;
  }

  // Update post
  Future<bool> updatePost(PostModel postModel) async {
    var response = await client.put(
      Uri.parse(baseURL + '/api/posts/${postModel.id.toString()}'),
      headers: <String, String>{"Content-Type": "application/json"},
      body: postToJson(postModel),
    );

    if (response.statusCode == 200) return true;
    return false;
  }

  // Delete post
  Future<bool> deletePost(int? id) async {
    var response = await client.delete(
      Uri.parse(baseURL + '/api/posts/${id.toString()}'),
      headers: <String, String>{"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) return true;
    return false;
  }
}
