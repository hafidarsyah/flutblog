import 'package:flutter/material.dart';

import 'package:application/utils/contants.dart';
import 'package:application/models/post_model.dart';

class DetailScreen extends StatefulWidget {
  final PostModel? postModel;

  DetailScreen({required this.postModel});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: Text(
          'Detail',
          style: primaryText.copyWith(color: secondaryColor),
        ),
        backgroundColor: primaryColor,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: size.width * 0.8,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.postModel!.title,
                  style:
                      primaryText.copyWith(fontSize: 24, color: primaryColor),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  widget.postModel!.description,
                  style: TextStyle(height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
