import 'package:flutter_test/flutter_test.dart';
import 'package:fluttermapsadvance/core/network/network_manager.dart';
import 'package:fluttermapsadvance/features/maps/service/IMapService.dart';
import 'package:fluttermapsadvance/features/maps/service/maps_service.dart';

main() {
  IMapService mapService;
  setUp(() {
    mapService = MapService(NetworkRequestManager.instance.service, null);
  });

  test('get all cluster points', () async {
    final response = await mapService.getClusterPoints();

    expect(response, isNotNull);
  });
}
