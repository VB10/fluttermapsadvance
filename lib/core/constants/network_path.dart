import 'exception/route_path_not_found.dart';

enum NetworkPath { POINTS, POLYLINE, CLUSTER }

extension NetworkPathValue on NetworkPath {
  String get rawValue {
    switch (this) {
      case NetworkPath.POINTS:
        return "/map/points.json";
      case NetworkPath.CLUSTER:
        return "/map/cluster.json";
      case NetworkPath.POLYLINE:
        return "/map/polyline.json";
      default:
        throw RoutePathNotFound();
    }
  }
}
