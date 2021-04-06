import 'dart:convert';

List<AuthModel> authFromJson(String jsonData) {
  final results = json.decode(jsonData);
  return List<AuthModel>.from(
      results.map((result) => AuthModel.fromJson(result)));
}

String authToJson(AuthModel authModel) {
  final results = authModel.toJson();
  return json.encode(results);
}

class AuthModel {
  int? id;
  String? name;
  String email;
  String password;
  String? passwordConfirmation;

  AuthModel(
      {this.id,
      this.name,
      required this.email,
      required this.password,
      this.passwordConfirmation});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation
      };
}
