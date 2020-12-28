import 'coordinate.dart';
import 'package:vexana/vexana.dart';

class ClusterCoordinate extends INetworkModel<ClusterCoordinate> {
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

  @override
  ClusterCoordinate fromJson(Map<String, Object> json) =>
      ClusterCoordinate.fromJson(json);
}
