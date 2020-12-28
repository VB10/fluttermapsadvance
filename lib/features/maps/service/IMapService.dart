import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vexana/vexana.dart';

import '../model/cluster_coordinate.dart';
import '../model/coordinate.dart';

abstract class IMapService {
  final INetworkManager service;
  final GlobalKey<ScaffoldState> scaffoldKey;
  IMapService(this.service, this.scaffoldKey);

  Future<List<Coordinate>> getAllPoints();
  Future<ClusterCoordinate> getClusterPoints();

  void showErrorMessage(IErrorModel response) {
    if (this.scaffoldKey != null) {
      scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(response.description)));
    }
  }
}
