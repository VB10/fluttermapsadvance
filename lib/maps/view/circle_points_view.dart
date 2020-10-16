import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermapsadvance/maps/model/coordinate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/network/network_manager.dart';
import '../cubit/points_cubit.dart';
import '../service/IMapService.dart';
import '../service/maps_service.dart';

class CirclePointsView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  IMapService get mapService => MapService(NetworkManager.instance.service, scaffoldKey);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PointsCubit(mapService),
      child: buildScaffoldBody(),
    );
  }

  Widget buildScaffoldBody() => Scaffold(
        key: scaffoldKey,
        body: BlocConsumer<PointsCubit, PointsState>(
          listener: (context, state) {
            if (state.runtimeType == PointsError) {
              scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Error")));
            } else if (state.runtimeType == PointsInitial) {
              context.bloc<PointsCubit>().fetchPoints();
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case PointsLoading:
                return CircularProgressIndicator();
              case PointsCompleted:
                return pointsList(state);
                break;
              case PointsError:
                return Text((state as PointsError).message);
              default:
                context.bloc<PointsCubit>().fetchPoints();
                return Text("Hello");
            }
          },
        ),
      );

  Widget pointsList(PointsCompleted completed) {
    final coordinates = completed.coordinates;
    return GoogleMap(
      polylines: Set.from(coordinates.map((e) => polylineCreate(e, coordinates))),
      markers: Set.from(coordinates.map((e) => markerCreate(e))),
      initialCameraPosition: CameraPosition(target: coordinates.first.coordinate, zoom: 13),
    );
  }

  Marker markerCreate(Coordinate e) {
    return Marker(
      markerId: MarkerId(e.name),
      position: e.coordinate,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );
  }

  Polyline polylineCreate(Coordinate e, List<Coordinate> coordinates) {
    return Polyline(
        color: Colors.orange,
        width: 3,
        polylineId: PolylineId(e.name),
        points: coordinates.map((e) => e.coordinate).toList());
  }
}
