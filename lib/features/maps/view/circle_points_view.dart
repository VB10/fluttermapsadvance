import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermapsadvance/core/extension/context_extension.dart';
import 'package:fluttermapsadvance/features/_component/card/coordinate_card/coordinate_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/network/network_manager.dart';
import '../cubit/points_cubit.dart';
import '../model/coordinate.dart';
import '../service/IMapService.dart';
import '../service/maps_service.dart';

class CirclePointsView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  IMapService get mapService =>
      MapService(NetworkManager.instance.service, scaffoldKey);

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
              scaffoldKey.currentState
                  .showSnackBar(SnackBar(content: Text("Error")));
            } else if (state.runtimeType == PointsInitial) {
              context.bloc<PointsCubit>().fetchPoints();
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case PointsLoading:
                return CircularProgressIndicator();
              case PointsCompleted:
                return pointAndPlaceView(state, context);
              case PointsError:
                return Text((state as PointsError).message);
              default:
                context.bloc<PointsCubit>().fetchPoints();
                return CircularProgressIndicator();
            }
          },
        ),
      );

  Widget pointAndPlaceView(PointsCompleted completed, BuildContext context) {
    return Stack(
      children: [
        pointsList(completed, context),
        positionedPageView(context, completed),
      ],
    );
  }

  Positioned positionedPageView(
      BuildContext context, PointsCompleted completed) {
    return Positioned(
      height: context.dynamicHeight(0.12),
      bottom: 0,
      right: 0,
      left: -context.dynamicWidth(0.1),
      child: PageView.builder(
        onPageChanged: (value) {
          context
              .bloc<PointsCubit>()
              .changeSelectedCoordinate(value, completed.coordinates);
        },
        itemCount: completed.coordinates.length,
        controller: PageController(viewportFraction: 0.8),
        itemBuilder: (context, index) =>
            CoordinateCard(coordinate: completed.coordinates[index]),
      ),
    );
  }

  Widget pointsList(PointsCompleted completed, context) {
    final coordinates = completed.coordinates;
    return GoogleMap(
      // polylines:
      //     Set.from(coordinates.map((e) => polylineCreate(e, coordinates))),
      markers: Set.from(coordinates.map((e) => markerCreate(
          e, context, e == completed.coordinates[completed.selectedItem]))),
      initialCameraPosition:
          CameraPosition(target: coordinates.first.coordinate, zoom: 13),
    );
  }

  Marker markerCreate(Coordinate e, BuildContext context, bool isSelected) {
    return Marker(
      markerId: MarkerId(e.name),
      position: e.coordinate,
      icon: BitmapDescriptor.defaultMarkerWithHue(
          isSelected ? BitmapDescriptor.hueAzure : BitmapDescriptor.hueOrange),
    );
  }
}

// Polyline polylineCreate(Coordinate e, List<Coordinate> coordinates) {
//   return Polyline(
//       color: Colors.orange,
//       width: 3,
//       polylineId: PolylineId(e.name),
//       points: coordinates.map((e) => e.coordinate).toList());
// }