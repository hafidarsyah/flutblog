import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:application/utils/contants.dart';
import 'package:application/models/post_model.dart';
import 'package:application/services/post_service.dart';
import 'package:application/screens/form_screen.dart';
import 'package:application/screens/auth_screen.dart';

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostService _postService;
  late SharedPreferences _sharedPreferences;
  late final int? _userId;

  @override
  void initState() {
    super.initState();
    _postService = PostService();
    loginStatus();
  }

  loginStatus() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _userId = _sharedPreferences.getInt("userId");

    if (_sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AuthScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _sharedPreferences.clear();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => AuthScreen()),
                  (Route<dynamic> route) => false);
            },
            icon: Icon(
              Icons.logout,
            )),
        title: Text(
          'FlutBlog',
          style: primaryText.copyWith(color: secondaryColor),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: secondaryColor),
            onPressed: () async {
              dynamic result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormScreen()),
              );

              if (result != null) {
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Create Post Success')),
                );
              }
            },
          )
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return FutureBuilder(
            future: _postService.getPosts(),
            builder: (BuildContext context,
                    AsyncSnapshot<List<PostModel>?> snapshot) =>
                _checkData(snapshot, 3),
          );
        } else if (constraints.maxWidth >= 650) {
          return FutureBuilder(
            future: _postService.getPosts(),
            builder: (BuildContext context,
                    AsyncSnapshot<List<PostModel>?> snapshot) =>
                _checkData(snapshot, 2),
          );
        }
        return FutureBuilder(
          future: _postService.getPosts(),
          builder: (BuildContext context,
                  AsyncSnapshot<List<PostModel>?> snapshot) =>
              _checkData(snapshot, 1),
        );
      }),
    );
  }

  // Check data
  dynamic _checkData(snapshot, count) {
    if (snapshot.hasData) {
      // Success
      List<PostModel> posts = snapshot.data!;

      return _buildView(posts, count);
    } else if (snapshot.hasError) {
      // Error
      return Center(
        child: Text("Something wrong with message: ${snapshot.error}"),
      );
    }

    // Loading
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Widget view
  Widget _buildView(List<PostModel> posts, int count) {
    Size size = MediaQuery.of(context).size;

    return GridView.count(
      crossAxisCount: count,
      childAspectRatio: 16 / 9,
      children: List.generate(
        posts.length,
        (index) {
          PostModel post = posts[index];

          return Card(
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailScreen(id: post.id, userId: _userId),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: primaryText.copyWith(
                            fontSize: 18,
                            color: primaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          post.description,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[800],
                            height: 1.4,
                          ),
                          maxLines: 4,
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Created at ' +
                                post.createAt!.day.toString() +
                                " - " +
                                post.createAt!.month.toString() +
                                " - " +
                                post.createAt!.year.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                          if (_userId == post.userId)
                            Row(children: [
                              ElevatedButton(
                                onPressed: () async {
                                  dynamic result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FormScreen(postModel: post),
                                    ),
                                  );

                                  if (result != null) {
                                    setState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Update Post Success')),
                                    );
                                  }
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.yellow[800],
                                ),
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.yellow[100],
                                  ),
                                  tapTargetSize: MaterialTapTargetSize.padded,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.007,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Warning',
                                            style: primaryText.copyWith(
                                              color: Colors.red[800],
                                            ),
                                          ),
                                          content: Text(
                                            "Are you sure want to delete data ${post.title}?",
                                            style: primaryText.copyWith(
                                              color: primaryColor,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                _postService
                                                    .deletePost(post.id)
                                                    .then((isSuccess) {
                                                  setState(() {});

                                                  if (isSuccess) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Delete Post Success'),
                                                      ),
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Delete Post Failed'),
                                                      ),
                                                    );
                                                  }
                                                }).onError((error, stackTrace) {
                                                  print(error);
                                                });
                                              },
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                    color: Colors.blue[800]),
                                              ),
                                              style: ButtonStyle(
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  Colors.blue[100],
                                                ),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .padded,
                                              ),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "No",
                                                style: TextStyle(
                                                    color: Colors.grey[800]),
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child:
                                    Icon(Icons.delete, color: Colors.red[800]),
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.red[100]),
                                  tapTargetSize: MaterialTapTargetSize.padded,
                                ),
                              )
                            ]),
                        ]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
