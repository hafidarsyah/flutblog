import 'package:app/service/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check API
    // PostService().getPosts().then((value) => print("value: $value"));

    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
