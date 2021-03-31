import 'dart:convert';

class PostModel {
  int? id;
  String title;
  String description;

  PostModel({this.id, required this.title, required this.description});

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };

  // Debug
  // @override
  // String toString() {
  //   return 'PostModel{id: $id, title: $title, description: $description, created_at: $createdAt, updated_at: $updatedAt}';
  // }
}

// Decode
List<PostModel> postFromJson(String jsonData) {
  final result = json.decode(jsonData);
  return List<PostModel>.from(result.map((item) => PostModel.fromJson(item)));
}

// Encode
String postToJson(PostModel postModel) {
  final results = postModel.toJson();
  return json.encode(results);
}
