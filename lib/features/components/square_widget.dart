import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/datasources/models/video_model.dart';

Widget SquareWidget(Video video){
  return Container(
    width: 150,
    height: 40,
    margin: EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Image(
      width: 150.0,
      image: NetworkImage(video.thumbnailUrl),
    ),
        Container(
          child: Text(
            video.title,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}