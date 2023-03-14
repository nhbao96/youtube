import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/datasources/models/video_model.dart';

Widget SquareWidget(Video video){
  return Container(
    width: 200,
    height: 50,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(video.thumbnailUrl),
                ),
              ),
            ),
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
    ),
  );
}