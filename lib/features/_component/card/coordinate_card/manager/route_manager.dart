import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteManager extends IRouteManager {
  @override
  double calculateDistance(LatLng cordinate, LatLng secondCordinate) {
    return (Geolocator.distanceBetween(cordinate.latitude, cordinate.longitude,
                secondCordinate.latitude, secondCordinate.longitude))
            .roundToDouble() /
        1000;
  }
}

abstract class IRouteManager {
  double calculateDistance(LatLng cordinate, LatLng secondCordinate);
}
