import 'dart:async';
import 'dart:ui';

import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model/map_cluster_property.dart';
import 'model/map_marker.dart';

part './map_cluster.dart';

class MapHelper {
  static MapHelper _instance;

  static MapHelper get instance {
    if (_instance == null) _instance = MapHelper._init();
    return _instance;
  }

  MapHelper._init();

  ClusterProperty get clusterProperty => ClusterProperty(
      minClusterZoom: 0,
      maxClusterZoom: 19,
      clusterColor: Colors.blue,
      currentZoom: 15,
      clusterWidth: 80,
      clusterTextColor: Colors.white);

  Future<BitmapDescriptor> bitmapToasset(
      String assetName, bool isSelected) async {
    final icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), assetName);

    return icon;
  }

  Future<Fluster<MapMarker>> initClusterManager(
    List<MapMarker> markers,
    int minZoom,
    int maxZoom,
  ) async {
    assert(markers != null);
    assert(minZoom != null);
    assert(maxZoom != null);

    return Fluster<MapMarker>(
      minZoom: minZoom,
      maxZoom: maxZoom,
      radius: 150,
      extent: 2048,
      nodeSize: 64,
      points: markers,
      createCluster: (
        BaseCluster cluster,
        double lng,
        double lat,
      ) =>
          MapMarker(
        id: cluster.id.toString(),
        position: LatLng(lat, lng),
        isCluster: cluster.isCluster,
        clusterId: cluster.id,
        pointsSize: cluster.pointsSize,
        childMarkerId: cluster.childMarkerId,
      ),
    );
  }

  Future<List<Marker>> getClusterMarkers(
    Fluster<MapMarker> clusterManager,
    double currentZoom,
    Color clusterColor,
    Color clusterTextColor,
    int clusterWidth,
  ) {
    assert(currentZoom != null);
    assert(clusterColor != null);
    assert(clusterTextColor != null);
    assert(clusterWidth != null);

    if (clusterManager == null) return Future.value([]);

    return Future.wait(clusterManager.clusters(
        [-180, -90, 180, 90], currentZoom.toInt()).map((mapMarker) async {
      if (mapMarker.isCluster) {
        mapMarker.icon = await _getClusterMarker(
          mapMarker.pointsSize,
          clusterColor,
          clusterTextColor,
          clusterWidth,
        );
      }

      return mapMarker.toMarker();
    }).toList());
  }
}
