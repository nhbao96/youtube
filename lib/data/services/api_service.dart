import 'dart:convert';
import 'dart:io';

import '../datasources/models/channel_model.dart';
import '../datasources/models/video_model.dart';
import '../utilities/keys.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService._instantiate();

  late APIService _apiService;

  APIService() {
    _apiService = APIService._instantiate();
  }

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future getDataChannelFromApi({required String channelId}) {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': ApiConstant.API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    return http.get(uri, headers: headers);
  }

  Future getDataVideosPlaylistFromApi(
      {required String playlistId, required int totalVideos}) {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': totalVideos.toString(),
      'pageToken': _nextPageToken,
      'key': ApiConstant.API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    return http.get(uri, headers: headers);
  }

  Future getRelatedVideos(String videoId) {
    String url = 'https://www.googleapis.com/youtube/v3/search'
        '?part=snippet'
        '&type=video'
        '&maxResults=100'
        '&relatedToVideoId=$videoId'
        '&key=${ApiConstant.API_KEY}';

    return http.get(Uri.parse(url));
  }

  Future getTrendingKeywordsForSearch() {
    final queryParams = {
      "part": "snippet",
      "chart": "mostPopular",
      "regionCode": "VN",
      "maxResults": "5",
      "key": ApiConstant.API_KEY
    };
    final uri = Uri.parse("https://www.googleapis.com/youtube/v3/search?" +
        Uri(queryParameters: queryParams).query);
    return http.get(uri);
  }

  Future searchVideo(String query) {
    final apiKey = ApiConstant.API_KEY;
    final url =
        'https://www.googleapis.com/youtube/v3/search?key=$apiKey&part=snippet&q=$query&type=video';

    return http.get(Uri.parse(url));
  }

  Future autocomplete(String query) {
    final apiKey = ApiConstant.API_KEY;
    final url =
        'https://suggestqueries.google.com/complete/search?key=$apiKey&client=youtube&ds=yt&q=$query';
    return http.get(Uri.parse(url));
  }

  Future getTrendingMusicVideos(int maxResult) {
    final queryParams = {
      "part": "snippet",
      "chart": "mostPopular",
      "regionCode": "VN",
      "videoCategoryId": "10",
      "maxResults": maxResult.toString(),
      "key": ApiConstant.API_KEY
    };
    final uri = Uri.parse("https://www.googleapis.com/youtube/v3/videos?" +
        Uri(queryParameters: queryParams).query);
    return http.get(uri);
  }

  Future getTopTrackMusic(String country, String queryKey, int maxResult) {
    // Replace with your YouTube API key
    final apiKey =  ApiConstant.API_KEY;

    // Define the search query for the top music tracks in Vietnam
    String query = queryKey;// 'vietnam music';

    // Set the search parameters to get the top music tracks
    final url = Uri.https(
      'www.googleapis.com',
      '/youtube/v3/search',
      {
        'part': 'snippet',
        'q':  queryKey,
        'maxResults': maxResult.toString(),
        'type': 'video',
        'videoDefinition': 'high',
        'videoCategory': '10', // Vietnamese music category ID
        'regionCode': country, // Country code for Vietnam
        'chart': 'mostPopular', // Get the most popular videos
        'key': apiKey,
      },
    );

    // Get the search results from the YouTube Data API
    return http.get(url);
  }

  Future getDetailOfTopTracks(List<String> ids){
    final apiKey =  ApiConstant.API_KEY;
    final videoUrl = Uri.https(
      'www.googleapis.com',
      '/youtube/v3/videos',
      {
        'part': 'snippet',
        'id': ids.join(','),
        'key': apiKey,
      },
    );
    return  http.get(videoUrl);
  }
}
