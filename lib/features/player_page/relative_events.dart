import 'package:youtube_baonh/common/bases/base_event.dart';

class LoadRelatedVideos extends BaseEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

  String _idVideo;

  LoadRelatedVideos(this._idVideo);

  String get idVideo => _idVideo;
}