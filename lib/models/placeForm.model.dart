import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:placer/models/places.model.dart';

class PlacesFormModel {
  RxMap form = {
    "name": {}.obs,
    "description": {}.obs,
    "images": [].obs,
    "videos": [].obs,
    "address": 'address',
    'polygon': [
      [50.446321642234395, 30.52288921384348],
      [50.44608769792714, 30.523456969374383],
      [50.44651564116533, 30.523899375695166],
      [50.446752618152146, 30.523332360099406]
    ].obs
  }.obs;

  update(String key, value) {}

  List<LatLng> getPolygon() {
    List<dynamic> polygon =
        form['polygon'].map((List<double> latLng) => LatLng(latLng[0], latLng[1])).toList();
    return new List<LatLng>.from(polygon);
  }
}

final placesFormModel = PlacesFormModel();
