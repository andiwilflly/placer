import 'package:get/get.dart';

class PlacesFormModel {
  RxMap form = {"name": {}.obs, "description": {}.obs}.obs;

  update(String key, value) {}
}

final placesFormModel = PlacesFormModel();
