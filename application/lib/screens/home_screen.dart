import 'package:flutter/material.dart';

import 'package:application/utils/contants.dart';
import 'package:application/models/post_model.dart';
import 'package:application/services/post_service.dart';
import 'package:application/screens/form_screen.dart';

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostService postService;

  @override
  void initState() {
    super.initState();
    postService = PostService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FlutBlog',
          style: primaryText.copyWith(color: secondaryColor),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: secondaryColor),
            onPressed: () async {
              var result = await Navigator.push(
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
            future: postService.getPosts(),
            builder: (BuildContext context,
                    AsyncSnapshot<List<PostModel>?> snapshot) =>
                _checkData(snapshot, 3),
          );
        } else if (constraints.maxWidth >= 650) {
          return FutureBuilder(
            future: postService.getPosts(),
            builder: (BuildContext context,
                    AsyncSnapshot<List<PostModel>?> snapshot) =>
                _checkData(snapshot, 2),
          );
        }
        return FutureBuilder(
          future: postService.getPosts(),
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
                    builder: (context) => DetailScreen(postModel: post),
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
                          maxLines: 7,
                        ),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      ElevatedButton(
                        onPressed: () async {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormScreen(postModel: post),
                            ),
                          );
                          if (result != null) {
                            setState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Update Post Success')),
                            );
                          }
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.yellow[800],
                          ),
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
                                        color: primaryColor),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        postService
                                            .deletePost(post.id)
                                            .then((isSuccess) {
                                          setState(() {});
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text('Delete Post Success')),
                                        );
                                      },
                                      child: Text(
                                        "Yes",
                                        style:
                                            TextStyle(color: Colors.blue[800]),
                                      ),
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.blue[100],
                                        ),
                                        tapTargetSize:
                                            MaterialTapTargetSize.padded,
                                      ),
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "No",
                                        style:
                                            TextStyle(color: Colors.grey[800]),
                                      ),
                                    )
                                  ],
                                );
                              });
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.red[800]),
                        ),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red[100]),
                          tapTargetSize: MaterialTapTargetSize.padded,
                        ),
                      )
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

  // Navigate and display selection
  // void _navigateAndDisplaySelection(BuildContext context) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => FormScreen()),
  //   );

  //   ScaffoldMessenger.of(context)
  //     ..removeCurrentSnackBar()
  //     ..showSnackBar(SnackBar(content: Text("$result")));
  // }
}
