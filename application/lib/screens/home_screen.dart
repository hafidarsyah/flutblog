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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Navigate and display selection
  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormScreen()),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
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
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormScreen(
                          postModel: post,
                        ),
                      ),
                    );
                  },
                  child: Text('Edit'))
            ],
          ),
        );
      },
      itemCount: posts.length,
    );
  }
}
