import 'package:flutter/material.dart';

import 'package:application/utils/contants.dart';
import 'package:application/services/auth_service.dart';
import 'package:application/models/auth_model.dart';
import 'package:application/screens/home_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthService _authService = AuthService();

  bool _isSubmit = true;
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(_isSubmit == true ? 'Register' : 'Login',
              style: primaryText.copyWith(color: secondaryColor)),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_isSubmit)
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required name';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: primaryColor),
                        hintText: 'Write name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  SizedBox(height: size.height * 0.02),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required email';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: primaryColor),
                      hintText: 'Write email',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required password';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: primaryColor),
                      hintText: 'Write password',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  if (_isSubmit)
                    TextFormField(
                      controller: _passwordConfirmationController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required password confirmation';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password Confirmation',
                        labelStyle: TextStyle(color: primaryColor),
                        hintText: 'Write password confirmation',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  SizedBox(height: size.height * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() => _isLoading = true);

                        if (_isSubmit) {
                          AuthModel _authModel = AuthModel(
                            name: _nameController.text.toString(),
                            email: _emailController.text.toString(),
                            password: _passwordController.text.toString(),
                            passwordConfirmation:
                                _passwordConfirmationController.text.toString(),
                          );

                          _authService.register(_authModel).then((isSuccess) {
                            _isSubmit = false;
                            setState(() => _isLoading = false);
                          });
                        } else {
                          AuthModel _authModel = AuthModel(
                            email: _emailController.text.toString(),
                            password: _passwordController.text.toString(),
                          );

                          _authService.login(_authModel).then((isSuccess) {
                            setState(() => _isLoading = false);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          });
                        }
                      }
                    },
                    child: _isLoading
                        ? Theme(
                            data: Theme.of(context)
                                .copyWith(accentColor: secondaryColor),
                            child: SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator()),
                          )
                        : Text('Save'),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      tapTargetSize: MaterialTapTargetSize.padded,
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 18, horizontal: 28),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextButton(
                      onPressed: () {
                        _isSubmit = _isSubmit == true ? false : true;
                        setState(() {});
                      },
                      child: Text(_isSubmit == true ? 'Login' : 'Register'))
                ],
              ),
            ),
          ),
        ));
  }
}
