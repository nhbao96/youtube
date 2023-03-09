import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:youtube_baonh/data/datasources/models/video_model.dart';
import 'package:youtube_baonh/data/services/api_service.dart';

import '../datasources/models/channel_model.dart';



class ChannelRespository{
  late APIService _apiService;

  void updateAPIService(APIService apiService){
    _apiService = apiService;
  }

  Future<Channel> getChannel(String channelId) async {
    Completer<Channel> completer = Completer();
    try{
      Response response = await _apiService.getDataChannelFromApi(channelId: channelId);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body)['items'][0];

        Channel channel = Channel.fromMap(data);
        List<Video> videos = await getListVideosPlaylist(channel.uploadPlaylistId) as List<Video>;

        channel.videos = videos;
        print(channel.toString());
        completer.complete(channel);
      } else {
        throw json.decode(response.body)['error']['message'];
      }
    }catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<List<Video>> getListVideosPlaylist(String playlistId) async{
    Completer<List<Video>> completer = Completer();
    try{
      Response response = await _apiService.getDataVideosPlaylistFromApi(playlistId: playlistId);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        List<dynamic> videosJson = data['items'];

        // Fetch first eight videos from uploads playlist
        List<Video> videos = [];
        videosJson.forEach(
              (json) => videos.add(
            Video.fromMap(json['snippet']),
          ),
        );
        print("list videos = ${videos.length}");
        completer.complete(videos);
      } else {
        throw json.decode(response.body)['error']['message'];
      }
    }catch(e){
      completer.completeError(e.toString());
    }

    return completer.future;
  }

}