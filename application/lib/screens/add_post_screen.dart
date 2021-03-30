import 'package:flutter/material.dart';

import 'package:application/models/post_model.dart';
import 'package:application/services/post_service.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  // Service
  PostService _postService = PostService();

  // Process and validation
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextController
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Add Post"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _controllerTitle,
              // Validator
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }

                return null;
              },
            ),
            TextFormField(
              controller: _controllerContent,
              // Validator
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }

                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Check validate
                if (_formKey.currentState!.validate()) {
                  // Config loading, controllerText, post model and create post
                  setState(() => _isLoading = true);

                  String _title = _controllerTitle.text.toString();
                  String _content = _controllerContent.text.toString();

                  PostModel postModel = PostModel(
                    title: _title,
                    content: _content,
                  );

                  _postService.createPost(postModel).then((isSuccess) {
                    // Success insert data
                    setState(() => _isLoading = false);

                    if (isSuccess) {
                      Navigator.pop(context, 'Success');
                    }
                  });
                }
              },
              // Loading and text
              child: _isLoading ? CircularProgressIndicator() : Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
