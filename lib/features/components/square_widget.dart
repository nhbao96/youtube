import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/datasources/models/video_model.dart';

Widget SquareWidget(Video video){
  return Container(
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
          child: Text(
            video.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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