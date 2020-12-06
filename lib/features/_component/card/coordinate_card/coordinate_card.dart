import 'package:flutter/material.dart';

import '../../../maps/model/coordinate.dart';

class CoordinateCard extends StatelessWidget {
  final Coordinate coordinate;
  const CoordinateCard({
    Key key,
    @required this.coordinate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(coordinate.name),
        trailing: Icon(Icons.navigation_sharp),
        subtitle: Text("${coordinate.lat} - ${coordinate.long}"),
      ),
    );
  }
}
