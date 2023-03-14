class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;

  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelTitle,
  });

  factory Video.fromMap(Map<String, dynamic> snippet) {
    return Video(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      channelTitle: snippet['channelTitle'],
    );
  }

  factory Video.fromMapRelative(Map<String, dynamic> video) {
    return Video(
      id: video["id"]["videoId"],
      title: video["snippet"]["title"],
      thumbnailUrl: video["snippet"]["thumbnails"]["default"]["url"],
      channelTitle: video["snippet"]["title"],
    );
  }

  factory Video.fromMapTrendingMusic(Map<String, dynamic> video) {
    return Video(
      id: video["id"],
      title: video["snippet"]["title"],
      thumbnailUrl: video["snippet"]["thumbnails"]["medium"]["url"],
      channelTitle: video["snippet"]["channelTitle"],
    );
  }



  @override
  String toString() {
    return 'Video{id: $id, title: $title, thumbnailUrl: $thumbnailUrl, channelTitle: $channelTitle}';
  }
}