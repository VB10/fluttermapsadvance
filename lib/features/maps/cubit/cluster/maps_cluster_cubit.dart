import 'package:bloc/bloc.dart';
import 'package:fluster/fluster.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utility/map/map_helper.dart';
import '../../../../core/utility/map/model/map_cluster_property.dart';
import '../../../../core/utility/map/model/map_marker.dart';
import '../../model/coordinate.dart';
import '../google_maps/../cluster/maps_cluster_state.dart';

class MapsClusterCubit extends Cubit<MapsClusterState> {
  MapsClusterCubit() : super(MapsClusterInitial());
  final Set<Marker> mapMarkers = Set();

  GoogleMapController controller;
  List<Coordinate> coordinates;
  Fluster<MapMarker> _clusterManager;

  ClusterProperty clusterProperty = MapHelper.instance.clusterProperty;

  void initMapController(
      GoogleMapController controller, List<Coordinate> coordinates) {
    this.controller = controller;
    this.coordinates = coordinates;
    emit(MapsClusterLoad(controller));
    _initMarkers();
  }

  Future _initMarkers() async {
    var uuid = Uuid();
    final List<MapMarker> markers = coordinates
        .map(
          (data) => MapMarker(
              id: uuid.v4(),
              position: data.coordinate,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              infoWindow: InfoWindow(title: data.name ?? "VB10")),
        )
        .toList();

    _clusterManager = await MapHelper.instance.initClusterManager(
      markers,
      clusterProperty.minClusterZoom,
      clusterProperty.maxClusterZoom,
    );
    updateMarkers();
  }

  Future<void> updateMarkers([double updatedZoom]) async {
    if (_clusterManager == null || updatedZoom == clusterProperty.currentZoom)
      return;

    if (updatedZoom != null) clusterProperty.currentZoom = updatedZoom;

    final updatedMarkers = await MapHelper.instance.getClusterMarkers(
        _clusterManager,
        clusterProperty.currentZoom,
        clusterProperty.clusterColor,
        clusterProperty.clusterTextColor,
        clusterProperty.clusterWidth);

    emit(MapsClusterUpdate(Set.of(updatedMarkers)));
    showMarkerInfoWindow(updatedMarkers.first);
  }

  void showMarkerInfoWindow(Marker marker) {
    try {
      controller.showMarkerInfoWindow(marker.markerId);
    } catch (e) {
      Logger()
          .e("Cluster Circle Error(Doesn't found marker, marker in circle )");
    }
  }
}
