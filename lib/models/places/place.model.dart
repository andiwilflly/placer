import 'package:get/get.dart';

class IPlace extends GetxController {
  String id;
  Map<String, dynamic> name;
  Map<String, dynamic> description;
  String address;
  List<dynamic> images = [];
  List<dynamic> videos = [];
  List<dynamic> polygon;

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
}
