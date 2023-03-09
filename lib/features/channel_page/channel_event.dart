import 'package:youtube_baonh/common/bases/base_event.dart';

class LoadChannelEvent extends BaseEvent{
  String channelId;
  @override
  // TODO: implement props
  List<Object?> get props => throw [];

  LoadChannelEvent(this.channelId);
}