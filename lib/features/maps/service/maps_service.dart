import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttermapsadvance/core/constants/network_path.dart';
import 'package:fluttermapsadvance/features/maps/model/cluster_coordinate.dart';

import '../model/coordinate.dart';
import 'IMapService.dart';

class MapService extends IMapService {
  MapService(Dio service, GlobalKey<ScaffoldState> scaffoldKey)
      : super(service, scaffoldKey);

  @override
  Future<List<Coordinate>> getAllPoints() async {
    final response = await service.get(NetworkPath.POINTS.rawValue);

    if (response.statusCode == HttpStatus.ok) {
      final responseBody = response.data as List;
      return responseBody.map((e) => Coordinate.fromJson(e)).toList();
    } else {
      showErrorMessage(response);
      return null;
    }
  }

  @override
  Future<ClusterCoordinate> getClusterPoints() async {
    final response = await service.get(NetworkPath.CLUSTER.rawValue);

    if (response.statusCode == HttpStatus.ok) {
      final responseBody = response.data as Map;
      return ClusterCoordinate.fromJson(responseBody);
    } else {
      showErrorMessage(response);
      return null;
    }
  }
}
