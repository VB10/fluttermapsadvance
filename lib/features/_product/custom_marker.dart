import 'dart:ui';

import '../../core/utility/map/map_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerManager extends CustomMarker {
  Map<int, BitmapDescriptor> _markers = {};

  Future<BitmapDescriptor> getCustomMarker({
    int value,
    Color clusterColor,
    Color textColor,
    int width,
  }) async {
    final marker = _markers[value];
    if (marker != null) {
      return marker;
    } else {
      final newMarker = await CustomMarker(
              clusterColor: clusterColor,
              width: width,
              textColor: textColor,
              clusterSize: value)
          .getCustomMarker();
      _markers[value] = newMarker;
      return newMarker;
    }
  }
}
