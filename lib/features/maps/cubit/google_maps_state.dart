import 'package:flutter/material.dart';
import 'package:fluttermapsadvance/features/maps/model/coordinate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
abstract class GoogleMapsState {
  final GoogleMapController controller;
  final int currentIndex;

  GoogleMapsState(this.controller, this.currentIndex);
}

class GoogleMapsStateInitial extends GoogleMapsState {
  GoogleMapsStateInitial(GoogleMapController controller, int currentIndex)
      : super(controller, currentIndex);
}

class MapsMarkerChange extends GoogleMapsState {
  final Coordinate coordinate;
  MapsMarkerChange(
      GoogleMapController controller, int currentIndex, this.coordinate)
      : super(controller, currentIndex);

  void changeSelectedMarker() {
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: coordinate.coordinate)));
  }
}
