import 'dart:convert';

class PostModel {
  int? id;
  String title;
  String description;
  DateTime? createAt;

  PostModel(
      {this.id, required this.title, required this.description, this.createAt});

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "createAt": createAt?.toIso8601String(),
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
