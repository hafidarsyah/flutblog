import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostService {
  final Uri baseURL = Uri.parse('http://127.0.0.1:8000/api/posts');

  Future<List<PostModel>?> getPosts() async {
    final response = await http.get(baseURL);

    if (response.statusCode == 200) return postFromJson(response.body);
    return null;
  }

  Future<bool> createPost(PostModel postModel) async {
    final response = await http.post(
      baseURL,
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: postToJson(postModel),
    );

    if (response.statusCode == 201) return true;
    return false;
  }
}
