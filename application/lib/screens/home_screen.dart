import 'package:flutter/material.dart';

import 'package:application/models/post_model.dart';
import 'package:application/services/post_service.dart';

import 'package:application/screens/form_screen.dart';

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
      body: FutureBuilder(
        future: postService.getPosts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PostModel>?> snapshot) =>
                _checkData(snapshot),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormScreen()),
          );
          if (result != null) {
            setState(() {});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Success')));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Check data
  dynamic _checkData(snapshot) {
    if (snapshot.hasData) {
      // Success
      List<PostModel> posts = snapshot.data!;

      return _buildListView(posts);
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

  // Widget list view
  Widget _buildListView(List<PostModel> posts) {
    return ListView.builder(
      itemBuilder: (context, index) {
        PostModel post = posts[index];

        return Card(
          child: Column(
            children: [
              Text(post.title),
              Text(post.content),
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
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Success')));
                  }
                },
                child: Text('Edit'),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Warning'),
                          content: Text(
                              "Are you sure want to delete data ${post.title}?"),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                postService
                                    .deletePost(post.id)
                                    .then((isSuccess) {
                                  setState(() {});
                                });
                              },
                              child: Text("Yes"),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("No"),
                            )
                          ],
                        );
                      });
                },
                child: Text('Delete'),
              )
            ],
          ),
        );
      },
      itemCount: posts.length,
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
