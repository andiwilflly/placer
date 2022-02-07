class Place {
  String id;
  Map<String, String> name;
  Map<String, String> description;
  String address;
  List<String> images = [];
  List<String> videos = [];
  List<List<double>> polygon;

  Place(
      {required this.id,
      required this.name,
      required this.description,
      required this.address,
      required this.images,
      required this.videos,
      required this.polygon});
}
