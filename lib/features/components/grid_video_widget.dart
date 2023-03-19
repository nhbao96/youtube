import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/datasources/models/video_model.dart';
import '../player_page/video_screen.dart';

Widget GridItemWidget(BuildContext context, Video video){
  return  GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoScreenPage(video),
      ),
    ),
    child: Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image(
            height: 80.0,
            width: 80,
            fit: BoxFit.fill,
            image: NetworkImage(video.thumbnailUrl),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            video.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );
}