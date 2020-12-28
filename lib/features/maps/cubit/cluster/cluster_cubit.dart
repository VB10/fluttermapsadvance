import 'package:bloc/bloc.dart';

import '../../service/IMapService.dart';
import 'cluster_state.dart';

class ClusterCubit extends Cubit<ClusterState> {
  ClusterCubit(this.mapService) : super(ClusterInitial());

  final IMapService mapService;

  Future<void> fetchAllPoints() async {
    final responseItems = await mapService.getClusterPoints();
    if (responseItems != null)
      emit(ClusterCompleted(responseItems));
    else
      emit(ClusterError("Data Not Found"));
  }
}
