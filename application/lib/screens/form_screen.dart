import 'package:application/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:application/models/post_model.dart';
import 'package:application/services/post_service.dart';

class FormScreen extends StatefulWidget {
  PostModel? postModel;

  FormScreen({this.postModel});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // Declaration initState
  PostService _postService = PostService();

  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerContent = TextEditingController();

  @override
  void initState() {
    if (widget.postModel != null) {
      _controllerTitle.text = widget.postModel!.title;
      _controllerContent.text = widget.postModel!.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(widget.postModel == null ? 'Form Add' : 'Form Edit'),
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
                  // Declartion loading, controller, & model
                  setState(() => _isLoading = true);

                  String _title = _controllerTitle.text.toString();
                  String _content = _controllerContent.text.toString();

                  PostModel _postModel = PostModel(
                    title: _title,
                    content: _content,
                  );

                  if (widget.postModel == null) {
                    // Create post
                    _postService.createPost(_postModel).then((isSuccess) {
                      setState(() => _isLoading = false);

                      if (isSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }
                    });
                  } else {
                    // Update post
                    _postModel.id = widget.postModel!.id;

                    _postService.updatePost(_postModel).then((isSuccess) {
                      setState(() => _isLoading = false);

                      if (isSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }
                    });
                  }
                }
              },
              // Loading or text
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text(widget.postModel == null ? 'Submit' : 'Update'),
            )
          ],
        ),
      ),
    );
  }
}
