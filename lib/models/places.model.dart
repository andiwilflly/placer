import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesModel {
  final places = GetStorage();

  void fetch() async {
    var response = await http.get(Uri.parse('fetchUrl'));
    var jsonResponse = convert.jsonDecode(response.body);

    print('places:');
    print(jsonResponse);
  }


  create(IPlace place) async {
    var response = await http.post(Uri.parse('fetchUrl'), body: place);
    var jsonResponse = convert.jsonDecode(response.body);
  }
}


class IPlace {
  Map<String, String> name = {};
  Map<String, String> description = {};
  List<String> images = [];
  List<String> videos = [];
}
