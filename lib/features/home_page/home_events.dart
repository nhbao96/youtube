import 'package:youtube_baonh/common/bases/base_event.dart';

class LoadTrendingMusicSliderEvent extends BaseEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

  LoadTrendingMusicSliderEvent();
}

class LoadCountryTracksEvent extends BaseEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
  String _id;
  String _queryKey;
  String _nameLayout;
  String get id => _id ?? "";

  String get queryKey => _queryKey;

  String get nameLayout => _nameLayout;

  LoadCountryTracksEvent(this._id, this._queryKey, this._nameLayout);
}

class LoadTrendingSingerChannelEvent extends BaseEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
int _maxResult;

  int get maxResult => _maxResult;

  LoadTrendingSingerChannelEvent(this._maxResult);
}
