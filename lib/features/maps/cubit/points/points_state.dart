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

  final int selectedItem;

  PointsCompleted(this.coordinates, {this.selectedItem});

  PointsCompleted copyWith({
    List<Coordinate> coordinates,
    int selectedItem,
  }) {
    return PointsCompleted(coordinates ?? this.coordinates,
        selectedItem: selectedItem ?? this.selectedItem);
  }
}
