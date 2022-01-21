import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';

class MapModel {
  late MapController controller;

  RxDouble zoom = 16.0.obs;

  void updateController(MapController mapController) {
    controller = mapController;
  }

  updateZoom(double newZoom) {
    zoom.value = newZoom;
  }
}
