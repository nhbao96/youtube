import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_baonh/data/datasources/models/channel_model.dart';

Widget ChannelSingerWidget(BuildContext context, Channel channel){
  return GestureDetector(
    onTap: (){
      Navigator.pushNamed(context, "channel-page",arguments: {'idChannel' : channel.id});
    },
    child: Container(
      width: 150,
      height: null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(channel.profilePictureUrl),
            ),
          ),
          Container(
            alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10),
              child: Text(channel.title, textAlign: TextAlign.center, style: TextStyle(fontSize: 14,color: Colors.white),))
        ],
      ),
    ),
  );
}

Widget horizontalListSingers(BuildContext context, List<Channel> channels){
  return Container(
    height: 170,
    margin: EdgeInsets.only(top: 10),
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: channels.length,
        itemExtent: null,
        itemBuilder: (context,index){
          return ChannelSingerWidget(context,channels[index]);
        }),
  );
}