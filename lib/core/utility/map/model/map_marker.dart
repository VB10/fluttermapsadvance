import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarker extends Clusterable {
  final String id;
  final LatLng position;
  BitmapDescriptor icon;
  InfoWindow infoWindow;

  MapMarker({
    @required this.id,
    @required this.position,
    this.infoWindow,
    this.icon,
    isCluster = false,
    clusterId,
    pointsSize,
    childMarkerId,
  }) : super(
          markerId: id,
          latitude: position.latitude,
          longitude: position.longitude,
          isCluster: isCluster,
          clusterId: clusterId,
          pointsSize: pointsSize,
          childMarkerId: childMarkerId,
        );

  Marker toMarker() => Marker(
      markerId: MarkerId(isCluster ? 'cl_$id' : id),
      position: LatLng(
        position.latitude,
        position.longitude,
      ),
      icon: icon,
      infoWindow: infoWindow);
}
