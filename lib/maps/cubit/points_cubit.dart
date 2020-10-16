import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttermapsadvance/maps/model/coordinate.dart';
import 'package:fluttermapsadvance/maps/service/IMapService.dart';

part 'points_state.dart';

class PointsCubit extends Cubit<PointsState> {
  PointsCubit(this.mapService) : super(PointsInitial());

  final IMapService mapService;

  Future<void> fetchPoints() async {
    final responseItems = await mapService.getAllPoints();
    if (responseItems != null)
      emit(PointsCompleted(responseItems));
    else
      emit(PointsError("Data Not Found"));
  }
}
