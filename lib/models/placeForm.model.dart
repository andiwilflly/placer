import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class PlacesFormModel {
  RxMap form = {
    "name": {}.obs,
    "description": {}.obs,
    "images": [].obs,
    "videos": [].obs,
    'polygon': [LatLng(32.3078, -64.7505), LatLng(25.7617, -80.1918), LatLng(18.4655, -66.1057)].obs
  }.obs;

  update(String key, value) {}
}

final placesFormModel = PlacesFormModel();
