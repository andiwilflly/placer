import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert' as convert;

final String? HOST = dotenv.env['SERVER_HOST'];
final String? PORT = dotenv.env['SERVER_PORT'];

class PlacesModel {
  final places = GetStorage();

  void all() async {
    print('$HOST:$PORT/api/places');

    var response = await http.get(
      Uri.parse('$HOST:$PORT/api/places'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    var jsonResponse = convert.jsonDecode(response.body);

    print('places:');
    print(jsonResponse);
  }

  create(RxMap<dynamic, dynamic> place) async {
    print(convert.json.encode(place));

    var response = await http.post(Uri.parse('$HOST:$PORT/api/places'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: convert.jsonEncode(place));
    var jsonResponse = convert.jsonDecode(response.body);

    print('creada? ~$jsonResponse');
  }
}

class IPlace {
  Map<String, String> name = {};
  Map<String, String> description = {};
  String address = '';
  List<String> images = [];
  List<String> videos = [];
  List<List<double>> polygon = [];
}
