import 'dart:convert';

class PostModel {
  int? id;
  String title;
  String content;

  PostModel({this.id, required this.title, required this.content});

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
      };

  // @override
  // String toString() {
  //   return 'PostModel{id: $id, title: $title, content: $content, created_at: $createdAt, updated_at: $updatedAt}';
  // }
}

List<PostModel> postFromJson(String jsonData) {
  final result = json.decode(jsonData);
  return List<PostModel>.from(result.map((item) => PostModel.fromJson(item)));
}

String postToJson(PostModel postModel) {
  final results = postModel.toJson();
  return json.encode(results);
}
