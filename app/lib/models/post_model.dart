// To parse this JSON data, do
//
//     final respone = responeFromJson(jsonString);

import 'dart:convert';

// respone dari json
List<PostModel> postFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<PostModel>.from(data.map((item) => PostModel.fromJson(item)));
}

// respone ke json
String postToJson(PostModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

class PostModel {
  int id;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  // constructor
  PostModel({
    this.id,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  // factory berfungsi supaya tidak membuat objek baru ketika panggil named constructor
  // dari json
  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  // ke json
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  @override
  String toString() {
    return 'PostModel{id: $id, title: $title, content: $content, created_at: $createdAt, updated_at: $updatedAt}';
  }
}
