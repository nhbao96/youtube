import 'package:youtube_baonh/data/datasources/models/video_model.dart';

class VideosResponse{
  String? _id;
  List<Video>? _videos;
  String? _nameLayout;
  String get id => _id ?? "";

  VideosResponse({id, videos,nameLayout}){
    _id = id;
    _videos = _videos;
    _nameLayout = nameLayout;
  }

  set id(String value) {
    _id = value;
  }

  List<Video> get videos => _videos ?? [];

  set videos(List<Video> value) {
    _videos = value;
  }

  String get nameLayout => _nameLayout ?? "";

  set nameLayout(String value) {
    _nameLayout = value;
  }
}