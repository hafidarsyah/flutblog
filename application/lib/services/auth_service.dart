import 'dart:convert';

import 'package:http/http.dart' as client;

import 'package:application/models/auth_model.dart';

class AuthService {
  final String baseURL = 'http://127.0.0.1:8000';

  Future<bool> register(AuthModel authModel) async {
    final response = await client.post(Uri.parse(baseURL + '/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: authToJson(authModel));

    if (response.statusCode == 201) return true;
    return false;
  }
}
