import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapsClusterState {}

class MapsClusterInitial extends MapsClusterState {}

class MapsClusterLoad extends MapsClusterState {
  final GoogleMapController controller;

  MapsClusterLoad(this.controller);
}

class MapsClusterUpdate extends MapsClusterState {
  final Set<Marker> mapMarkers;
  MapsClusterUpdate(this.mapMarkers);
}
