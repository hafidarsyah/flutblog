import 'package:app/models/post_model.dart';
import 'package:app/services/post_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PostService postService = PostService();

  // @override
  // void initState() {
  //   super.initState();
  //   postService = PostService();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: postService.getPosts(),
          builder:
              (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Something wrong with message: ${snapshot.error.toString()}"),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              List<PostModel> posts = snapshot.data;
              return _buildListView(posts);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildListView(List<PostModel> posts) {
    return ListView.builder(
      itemBuilder: (context, index) {
        PostModel post = posts[index];
        return Card(
          child: Column(
            children: [Text(post.title), Text(post.content)],
          ),
        );
      },
      itemCount: posts.length,
    );
  }
}
