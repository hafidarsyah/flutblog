import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostService {
  // Base URL API
  final String baseURL = 'http://127.0.0.1:8000';

  // Get all posts
  Future<List<PostModel>?> getPosts() async {
    final response = await http.get(Uri.parse(baseURL + '/api/posts'));

    if (response.statusCode == 200) return postFromJson(response.body);
    return null;
  }

  // Create post
  Future<bool> createPost(PostModel postModel) async {
    final response = await http.post(
      Uri.parse(baseURL + '/api/posts'),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: postToJson(postModel),
    );

    if (response.statusCode == 201) return true;
    return false;
  }

  // Update post
  Future<bool> updatePost(PostModel postModel) async {
    final response = await http.put(
      Uri.parse(baseURL + '/api/posts/${postModel.id.toString()}'),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: postToJson(postModel),
    );

    if (response.statusCode == 200) return true;
    return false;
  }

  // Delete post
  Future<bool> deletePost(int? id) async {
    final response = await http.delete(
      Uri.parse(baseURL + '/api/posts/${id.toString()}'),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
    );

    if (response.statusCode == 200) return true;
    return false;
  }
}
