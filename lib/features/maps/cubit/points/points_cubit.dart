import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../model/coordinate.dart';
import '../../service/IMapService.dart';

part 'points_state.dart';

class PointsCubit extends Cubit<PointsState> {
  PointsCubit(this.mapService) : super(PointsInitial());

  final IMapService mapService;

  Future<void> fetchPoints() async {
    final responseItems = await mapService.getAllPoints();
    if (responseItems != null)
      emit(PointsCompleted(responseItems, selectedItem: 0));
    else
      emit(PointsError("Data Not Found"));
  }

  Future<void> fetchPointsCustomMarker() async {
    final responseItems = await mapService.getAllPoints();
    if (responseItems != null)
      emit(PointsCompleted(responseItems, selectedItem: 0));
    else
      emit(PointsError("Data Not Found"));
  }

  void changeSelectedCoordinate(int index, List<Coordinate> items) {
    final _state = state as PointsCompleted;
    emit(_state.copyWith(selectedItem: index));
  }
}
