import 'package:dio/dio.dart';
import 'package:vexana/vexana.dart';

class NetworkRequestManager {
  static NetworkRequestManager _instace;
  static NetworkRequestManager get instance {
    if (_instace == null) _instace = NetworkRequestManager._init();
    return _instace;
  }

  final String _baseUrl = "https://hwasampleapi.firebaseio.com";

  INetworkManager service;

  NetworkRequestManager._init() {
    service = NetworkManager(options: BaseOptions(baseUrl: _baseUrl));
  }
}
