import 'package:youtube_baonh/data/datasources/models/video_model.dart';


class Channel {

  final String id;
  final String title;
  final String profilePictureUrl;
  final String subscriberCount;
  final String videoCount;
  final String uploadPlaylistId;
  List<Video> videos;

  Channel({
    required this.id,
    required this.title,
    required this.profilePictureUrl,
    required this.subscriberCount,
    required this.videoCount,
    required this.uploadPlaylistId,
    required this.videos,
  });

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      id: map['id'],
      title: map['snippet']['title'],
      profilePictureUrl: map['snippet']['thumbnails']['default']['url'],
      subscriberCount: map['statistics']['subscriberCount'],
      videoCount: map['statistics']['videoCount'],
      uploadPlaylistId: map['contentDetails']['relatedPlaylists']['uploads'], videos: [],
    );
  }

  factory Channel.fromMapTopSinger(Map<String, dynamic> map) {
    return Channel(
      id:map['snippet']['channelId'],
      title: map['snippet']['channelTitle'],
      profilePictureUrl: map['snippet']['thumbnails']['default']['url'],
      subscriberCount: '0',
      videoCount: '',
      uploadPlaylistId: '', videos: [],
    );
  }

  @override
  String toString() {
    return 'Channel{id: $id, title: $title, profilePictureUrl: $profilePictureUrl, subscriberCount: $subscriberCount, videoCount: $videoCount, uploadPlaylistId: $uploadPlaylistId, videos: $videos}';
  }
}