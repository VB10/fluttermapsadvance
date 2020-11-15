import 'package:fluttermapsadvance/features/maps/model/coordinate.dart';

class ClusterCoordinate {
  List<Coordinate> coordinates = [];

  ClusterCoordinate({this.coordinates});

  ClusterCoordinate.fromJson(Map<String, dynamic> json) {
    if (json['coordinates'] != null) {
      json['coordinates'].forEach((v) {
        final _list = v as List;
        coordinates.add(Coordinate(lat: _list.first, long: _list.last));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }
}
