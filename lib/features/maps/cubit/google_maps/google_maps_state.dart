import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttermapsadvance/features/maps/model/coordinate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
abstract class GoogleMapsState extends Equatable {
  final GoogleMapController controller;
  final int currentIndex;

  GoogleMapsState(this.controller, this.currentIndex);
}

class GoogleMapsStateInitial extends GoogleMapsState {
  GoogleMapsStateInitial(GoogleMapController controller, int currentIndex)
      : super(controller, currentIndex);

  @override
  List<Object> get props => [controller, currentIndex];
}

class MapsMarkerChange extends GoogleMapsState {
  MapsMarkerChange(GoogleMapController controller, int currentIndex)
      : super(controller, currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
