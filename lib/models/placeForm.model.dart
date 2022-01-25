import 'package:get/get.dart';

class PlacesFormModel {
  RxMap form = {
    "name": {}.obs,
    "description": {}.obs,
    "images": [].obs,
    "videos": [].obs
  }.obs;

  update(String key, value) {}
}

final placesFormModel = PlacesFormModel();
