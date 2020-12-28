import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/network/network_manager.dart';
import '../cubit/cluster/cluster_cubit.dart';
import '../cubit/cluster/cluster_state.dart';
import '../cubit/cluster/maps_cluster_cubit.dart';
import '../cubit/cluster/maps_cluster_state.dart';
import '../model/cluster_coordinate.dart';
import '../service/IMapService.dart';
import '../service/maps_service.dart';

class ClusterPointsView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  IMapService get mapService =>
      MapService(NetworkRequestManager.instance.service, scaffoldKey);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ClusterCubit(mapService)),
        BlocProvider(create: (context) => MapsClusterCubit()),
      ],
      child: Scaffold(
        key: scaffoldKey,
        body: BlocConsumer<ClusterCubit, ClusterState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case ClusterInitial:
                fetchAllPoints(context);
                return buildCenterLoading;
              case ClusterCompleted:
                return clusterMapView((state as ClusterCompleted).coordinate);
              default:
                return buildCenterLoading;
            }
          },
        ),
      ),
    );
  }

  void fetchAllPoints(BuildContext context) {
    Future.microtask(() {
      context.read<ClusterCubit>().fetchAllPoints();
    });
  }

  Center get buildCenterLoading => Center(child: CircularProgressIndicator());

  Widget clusterMapView(ClusterCoordinate cluster) {
    return BlocConsumer<MapsClusterCubit, MapsClusterState>(
      listener: (context, state) {
        if (state is MapsClusterUpdate) {
          scaffoldKey.currentState.hideCurrentSnackBar();
          scaffoldKey.currentState.showSnackBar(snackBarWidget);
        }
      },
      builder: (context, state) {
        Set<Marker> markers;
        if (state is MapsClusterUpdate) {
          markers = state.mapMarkers;
        }
        return GoogleMap(
          onMapCreated: (controller) {
            context
                .read<MapsClusterCubit>()
                .initMapController(controller, cluster.coordinates);
          },
          markers: markers,
          onCameraMove: (position) =>
              context.read<MapsClusterCubit>().updateMarkers(position.zoom),
          initialCameraPosition: CameraPosition(
              target: cluster.coordinates.first.coordinate, zoom: 13),
        );
      },
    );
  }

  SnackBar get snackBarWidget => SnackBar(
        content: Row(
          children: [
            Icon(Icons.check),
            Text("Completed"),
          ],
        ),
      );
}
