import 'package:application/models/auth_model.dart';
import 'package:application/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:application/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _form = true;

  AuthService _authService = AuthService();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          if (_form) TextField(controller: _nameController),
          TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress),
          TextField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword),
          if (_form)
            TextField(
                controller: _passwordConfirmationController,
                keyboardType: TextInputType.visiblePassword),
          ElevatedButton(
            onPressed: () {
              if (_form) {
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
              } else {
                AuthModel _authModel = AuthModel(
                  email: _emailController.text.toString(),
                  password: _passwordController.text.toString(),
                );

                _authService.login(_authModel).then((isSuccess) {
                  setState(() {});
                });
              }
            },
            child: Text(_form == true ? 'Register' : 'Login'),
          ),
          TextButton(
              onPressed: () {
                _form = false;
                setState(() {});
              },
              child: Text(_form == true ? 'Login' : 'Register'))
        ],
      ),
    ));
  }
}
