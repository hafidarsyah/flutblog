import 'package:flutter/material.dart';

import 'package:application/utils/contants.dart';
import 'package:application/models/post_model.dart';
import 'package:application/services/post_service.dart';

class FormScreen extends StatefulWidget {
  final PostModel? postModel;

  FormScreen({this.postModel});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // Declaration
  PostService _postService = PostService();

  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();

  @override
  void initState() {
    if (widget.postModel != null) {
      _controllerTitle.text = widget.postModel!.title;
      _controllerDescription.text = widget.postModel!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(widget.postModel == null ? 'Form Create' : 'Form Update',
            style: primaryText.copyWith(color: secondaryColor)),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _controllerTitle,
                  // Validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required title';
                    }

                    return null;
                  },
                  autofocus: true,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: primaryColor),
                    hintText: 'Enter post title',
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
                  controller: _controllerDescription,
                  // Validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required description';
                    }

                    return null;
                  },
                  cursorColor: primaryColor,
                  maxLines: 18,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: primaryColor),
                    hintText: 'Enter post description',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Check validate
                    if (_formKey.currentState!.validate()) {
                      // Declartion loading, controller, & model
                      setState(() => _isLoading = true);

                      String _title = _controllerTitle.text.toString();
                      String _description =
                          _controllerDescription.text.toString();

                      PostModel _postModel = PostModel(
                        title: _title,
                        description: _description,
                      );

                      if (widget.postModel == null) {
                        // Create post
                        _postService.createPost(_postModel).then((isSuccess) {
                          setState(() => _isLoading = false);

                          if (isSuccess) {
                            Navigator.pop(context, true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Create Post Failed')),
                            );
                          }
                        });
                      } else {
                        // Update post
                        _postModel.id = widget.postModel!.id;

                        _postService.updatePost(_postModel).then((isSuccess) {
                          setState(() => _isLoading = false);

                          if (isSuccess) {
                            Navigator.pop(context, true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Create Post Failed')),
                            );
                          }
                        });
                      }
                    }
                  },
                  // Loading or text
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
