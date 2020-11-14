import 'package:bloc/bloc.dart';
import 'package:fluttermapsadvance/features/maps/model/coordinate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'google_maps_state.dart';

class GoogleMapsCubit extends Cubit<GoogleMapsState> {
  GoogleMapsCubit() : super(GoogleMapsStateInitial(null, 0));

  void initMapController(GoogleMapController controller) {
    emit(GoogleMapsStateInitial(controller, 0));
  }

  void changeMarker(int index, Coordinate coordinate) {
    state.controller
        .animateCamera(CameraUpdate.newLatLng(coordinate.coordinate));
    emit(MapsMarkerChange(state.controller, index));
  }
}
