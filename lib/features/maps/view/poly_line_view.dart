import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/network/network_manager.dart';
import '../../_component/card/coordinate_card/coordinate_card.dart';
import '../cubit/line/google_maps_cubit.dart';
import '../cubit/line/google_maps_state.dart';
import '../cubit/points/points_cubit.dart';
import '../model/coordinate.dart';
import '../service/IMapService.dart';
import '../service/maps_service.dart';

class PolyLineView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  IMapService get mapService =>
      MapService(NetworkRequestManager.instance.service, scaffoldKey);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PointsCubit(mapService)),
        BlocProvider(create: (context) => LineCubit()),
      ],
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
                fetchPoints(context);
                return CircularProgressIndicator();
            }
          },
        ),
      );

  void fetchPoints(BuildContext context) {
    Future.microtask(() {
      context.read<PointsCubit>().fetchPoints();
    });
  }

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
              .read<LineCubit>()
              .changeMarker(value, completed.coordinates[value]);
        },
        itemCount: completed.coordinates.length,
        controller: PageController(viewportFraction: 0.8),
        itemBuilder: (context, index) =>
            CoordinateCard(coordinate: completed.coordinates[index]),
      ),
    );
  }

  Widget pointsList(PointsCompleted completed, BuildContext context) {
    final coordinates = completed.coordinates;
    return BlocConsumer<LineCubit, LineState>(
      listener: (context, LineState state) {},
      builder: (context, state) {
        List<Marker> markers = [];
        int selectedLines = 0;
        if (state is GoogleMapsStateMarkers) {
          markers = state.marrkers;
        } else if (state is MapsMarkerChange) {
          selectedLines = state.currentIndex;
          markers = context.watch<LineCubit>().markers;
        }

        return GoogleMap(
          onMapCreated: (controller) {
            context
                .read<LineCubit>()
                .initMapControllerMarkers(controller, context, coordinates);
          },
          polylines: Set.from([polylineCreate(markers, selectedLines)]),
          markers: Set.from(markers),
          initialCameraPosition:
              CameraPosition(target: coordinates.first.coordinate, zoom: 13),
        );
      },
    );
  }

  Polyline polylineCreate(List<Marker> markers, int selectedLines) {
    return Polyline(
        width: 2,
        polylineId: PolylineId(markers.length.toString()),
        points: markers.map((e) => e.position).toList());
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
