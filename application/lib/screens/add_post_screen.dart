import 'package:application/models/post_model.dart';
import 'package:application/services/post_service.dart';
import 'package:flutter/material.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  // TextController
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Form Add Post"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _controllerTitle,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }

                return null;
              },
            ),
            TextFormField(
              controller: _controllerContent,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }

                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() => _isLoading = true);

                  String _title = _controllerTitle.text.toString();
                  String _content = _controllerContent.text.toString();

                  PostModel postModel = PostModel(
                    title: _title,
                    content: _content,
                  );

                  _postService.createPost(postModel).then((isSuccess) {
                    setState(() => _isLoading = false);

                    if (isSuccess) {
                      Navigator.pop(context);
                    }
                  });
                }
              },
              child: _isLoading ? CircularProgressIndicator() : Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
