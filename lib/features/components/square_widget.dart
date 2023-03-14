import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/datasources/models/video_model.dart';

Widget SquareWidget(){
  return Container(
    width: 100,
    height: 100,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.blue, // Replace this with your image
          ),
        ),
        Container(
          child: Text(
            'Title',
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