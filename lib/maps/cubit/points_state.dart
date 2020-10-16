part of 'points_cubit.dart';

@immutable
abstract class PointsState {}

class PointsInitial extends PointsState {}

class PointsLoading extends PointsState {}

class PointsError extends PointsState {
  final String message;

  PointsError(this.message);
}

class PointsCompleted extends PointsState {
  final List<Coordinate> coordinates;

  PointsCompleted(this.coordinates);
}
