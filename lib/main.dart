import 'package:flutter/material.dart';
import 'package:fluttermapsadvance/features/maps/view/circle_points_view.dart';
import 'package:fluttermapsadvance/features/maps/view/poly_line_view.dart';
import 'package:provider/provider.dart';

import 'features/_product/custom_marker.dart';
import 'features/maps/view/cluster_points_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MultiProvider(
        providers: [
          Provider(create: (context) => CustomMarkerManager(), lazy: true)
        ],
        child: CirclePointsView(),
      ),
    );
  }
}
