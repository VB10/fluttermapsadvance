import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
abstract class LineState extends Equatable {
  final GoogleMapController controller;
  final int currentIndex;

  LineState(this.controller, this.currentIndex);
}

class GoogleMapsStateInitial extends LineState {
  GoogleMapsStateInitial(GoogleMapController controller, int currentIndex)
      : super(controller, currentIndex);

  @override
  List<Object> get props => [controller, currentIndex];
}

class MapsMarkerChange extends LineState {
  MapsMarkerChange(GoogleMapController controller, int currentIndex)
      : super(controller, currentIndex);

  @override
  List<Object> get props => [currentIndex];
}

class GoogleMapsStateMarkers extends LineState {
  final List<Marker> marrkers;
  GoogleMapsStateMarkers(
      GoogleMapController controller, int currentIndex, this.marrkers)
      : super(controller, currentIndex);

  @override
  List<Object> get props => [controller, currentIndex];
}
