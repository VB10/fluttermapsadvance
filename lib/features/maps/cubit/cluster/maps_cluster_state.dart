import 'package:fluttermapsadvance/features/maps/model/cluster_coordinate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapsClusterState {}

class MapsClusterInitial extends MapsClusterState {}

class MapsClusterCompleted extends MapsClusterState {
  final ClusterCoordinate coordinate;

  MapsClusterCompleted(this.coordinate);
}

class MapsClusterError extends MapsClusterState {
  final String message;

  MapsClusterError(this.message);
}

class MapsClusterLoad extends MapsClusterState {
  final GoogleMapController controller;

  MapsClusterLoad(this.controller);
}

class MapsClusterUpdate extends MapsClusterState {
  final Set<Marker> mapMarkers;
  MapsClusterUpdate(this.mapMarkers);
}
