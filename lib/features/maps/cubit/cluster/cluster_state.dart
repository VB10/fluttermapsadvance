import '../../model/cluster_coordinate.dart';

abstract class ClusterState {}

class ClusterInitial extends ClusterState {}

class ClusterCompleted extends ClusterState {
  final ClusterCoordinate coordinate;

  ClusterCompleted(this.coordinate);
}

class ClusterError extends ClusterState {
  final String message;

  ClusterError(this.message);
}
