import 'package:youtube_baonh/data/datasources/models/video_model.dart';

class SearchModel{
  int? _typeDisplay;
  List<Video>? _videos;

  int get typeDisplay => _typeDisplay ?? 0;

  List<Video> get videos => _videos ?? [];

  set videos(List<Video> value) {
    _videos?.clear();
    _videos = value;
  }

  set typeDisplay(int value) {
    _typeDisplay = value;
  }

  SearchModel(this._typeDisplay, this._videos);
}