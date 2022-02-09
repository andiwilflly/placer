import 'package:get/get.dart';
import 'package:placer/models/store.dart';
import 'package:placer/utils/distance.utils.dart';

class IPlace extends GetxController {
  String id;
  Map<String, dynamic> name;
  Map<String, dynamic> description;
  String address;
  List<String> images = [];
  List<String> videos = [];
  List<List<double>> polygon; // TODO: List<List<double>>

  bool isSelected;

  IPlace(
      {required this.id,
      required this.name,
      required this.description,
      required this.address,
      required this.images,
      required this.videos,
      required this.polygon,
      this.isSelected = false});

  double get lat => getPolygonCenter(polygon)[0];

  double get long => getPolygonCenter(polygon)[1];

  int get distance {
    List<double> polygonCenter = getPolygonCenter(polygon);
    double meters =
        measure(store.location.lat.value, store.location.long.value, polygonCenter[0], polygonCenter[1]);
    return meters.round();
    // return (meters / 1000).toStringAsFixed(3);
  }
}
