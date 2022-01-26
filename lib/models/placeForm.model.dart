import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class PlacesFormModel {
  RxMap form = {
    "name": {}.obs,
    "description": {}.obs,
    "images": [].obs,
    "videos": [].obs,
    'polygon': [
      LatLng(50.44632057975247, 30.52289108708404,),
      LatLng(50.44608817297772, 30.523457302861544),
      LatLng(50.44651842560935, 30.52389568097548),
      LatLng(50.446753503282174, 30.523334583277652)
    ].obs
  }.obs;

  update(String key, value) {}
}

final placesFormModel = PlacesFormModel();
