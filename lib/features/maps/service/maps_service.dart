import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttermapsadvance/core/constants/network_path.dart';

import '../model/coordinate.dart';
import 'IMapService.dart';

class MapService extends IMapService {
  MapService(Dio service, GlobalKey<ScaffoldState> scaffoldKey) : super(service, scaffoldKey);

  @override
  Future<List<Coordinate>> getAllPoints() async {
    final response = await service.get(NetworkPath.POINTS.rawValue);

    if (response.statusCode == HttpStatus.ok) {
      final responseBody = response.data as List;
      return responseBody.map((e) => Coordinate.fromJson(e)).toList();
    } else {
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(response.statusMessage)));
      return null;
    }
  }
}
