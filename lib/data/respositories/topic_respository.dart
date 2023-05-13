import 'package:youtube_baonh/data/datasources/remote/api_request.dart';
import 'package:youtube_baonh/data/services/api_service.dart';

class TopicRespository{
  late APIService _apiService;

  void updateApiService(APIService apiService){
    _apiService = apiService;
  }


}