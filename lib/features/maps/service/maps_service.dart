import 'package:flutter/material.dart';
import 'package:vexana/vexana.dart';

import '../../../core/constants/network_path.dart';
import '../model/cluster_coordinate.dart';
import '../model/coordinate.dart';
import 'IMapService.dart';

class MapService extends IMapService {
  MapService(INetworkManager service, GlobalKey<ScaffoldState> scaffoldKey)
      : super(service, scaffoldKey);

  @override
  Future<List<Coordinate>> getAllPoints() async {
    final response = await service.fetch<Coordinate, List<Coordinate>>(
        NetworkPath.POINTS.rawValue,
        parseModel: Coordinate(),
        method: RequestType.GET);

    if (response.data != null) {
      return response.data;
    } else {
      showErrorMessage(response.error);
      return null;
    }
  }

  @override
  Future<ClusterCoordinate> getClusterPoints() async {
    final response = await service.fetch<ClusterCoordinate, ClusterCoordinate>(
        NetworkPath.CLUSTER.rawValue,
        parseModel: ClusterCoordinate(),
        method: RequestType.GET);

    if (response.data != null)
      return response.data;
    else {
      showErrorMessage(response.error);
      return null;
    }
  }
}
