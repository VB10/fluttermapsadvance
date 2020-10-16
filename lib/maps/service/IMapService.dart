import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermapsadvance/maps/model/coordinate.dart';

abstract class IMapService {
  final Dio service;
  final GlobalKey<ScaffoldState> scaffoldKey;
  IMapService(this.service, this.scaffoldKey);

  Future<List<Coordinate>> getAllPoints();
}
