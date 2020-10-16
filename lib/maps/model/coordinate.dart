import 'package:google_maps_flutter/google_maps_flutter.dart';

class Coordinate {
  double lat;
  double long;
  String name;

  LatLng get coordinate => LatLng(long, lat);

  Coordinate({this.lat, this.long, this.name});

  Coordinate.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['name'] = this.name;
    return data;
  }
}
