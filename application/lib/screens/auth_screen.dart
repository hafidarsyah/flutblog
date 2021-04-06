import 'package:application/models/auth_model.dart';
import 'package:flutter/material.dart';

import 'package:application/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthService _authService = AuthService();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextField(controller: _nameController),
        TextField(controller: _emailController),
        TextField(controller: _passwordController),
        TextField(controller: _passwordConfirmationController),
        ElevatedButton(
          onPressed: () {
            AuthModel _authModel = AuthModel(
              name: _nameController.text.toString(),
              email: _emailController.text.toString(),
              password: _passwordController.text.toString(),
              passwordConfirmation:
                  _passwordConfirmationController.text.toString(),
            );

            _authService.register(_authModel).then((isSuccess) {
              setState(() {});
              print('sucess');
            });
          },
          child: Text("Register"),
        )
      ],
    ));
  }
}
