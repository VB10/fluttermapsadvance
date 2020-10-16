import 'package:dio/dio.dart';

class NetworkManager {
  static NetworkManager _instace;
  static NetworkManager get instance {
    if (_instace == null) _instace = NetworkManager._init();
    return _instace;
  }

  final String _baseUrl = "https://hwasampleapi.firebaseio.com";

  Dio service;

  NetworkManager._init() {
    service = Dio(BaseOptions(baseUrl: _baseUrl));
  }
}
