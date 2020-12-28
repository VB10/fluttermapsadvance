import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vexana/vexana.dart';

class Coordinate extends INetworkModel<Coordinate> {
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

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Coordinate && o.lat == lat && o.long == long && o.name == name;
  }

  @override
  int get hashCode => lat.hashCode ^ long.hashCode ^ name.hashCode;

  @override
  Coordinate fromJson(Map<String, Object> json) => Coordinate.fromJson(json);
}
