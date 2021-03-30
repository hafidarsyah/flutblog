import 'package:application/screens/add_post_screen.dart';
import 'package:flutter/material.dart';

import 'package:application/models/post_model.dart';
import 'package:application/services/post_service.dart';

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
                _getDataCheck(snapshot),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPostScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Logic check data
  dynamic _getDataCheck(snapshot) {
    if (snapshot.hasData) {
      List<PostModel> posts = snapshot.data!;

      return _buildListView(posts);
    } else if (snapshot.hasError) {
      return Center(
        child: Text("Something wrong with message: ${snapshot.error}"),
      );
    }

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
            ],
          ),
        );
      },
      itemCount: posts.length,
    );
  }
}
