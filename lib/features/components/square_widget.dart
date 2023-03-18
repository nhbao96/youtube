import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/datasources/models/video_model.dart';
import '../player_page/video_screen.dart';

Widget SquareWidget(BuildContext context,Video video){
  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoScreenPage(video),
      ),
    ),
    child: Container(
      width: 150,
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Image(
        width: 150.0,
        height: 110,
        fit: BoxFit.fill,
        image: NetworkImage(video.thumbnailUrl),
      ),
          Container(
            height: null,
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              video.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}