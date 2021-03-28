import 'package:flutter/material.dart';
import 'service/post_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PostService().getPosts().then((value) => print("value: $value"));
    return MaterialApp(
      home: Scaffold(),
    );
  }
}
