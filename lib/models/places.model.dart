import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:placer/components/place/PlaceMarker.component.dart';
import 'dart:convert' as convert;

import 'package:placer/models/store.dart';

final String? HOST = dotenv.env['SERVER_HOST'];
final String? PORT = dotenv.env['SERVER_PORT'];

class PlacesModel {
  final GetStorage all = GetStorage();

  void getAll() async {
    print('$HOST:$PORT/api/places');

    var response = await http.get(
      Uri.parse('$HOST:$PORT/api/places'),
      headers: {'Content-Type': 'application/json'},
    );
    var jsonResponse = convert.jsonDecode(response.body);

    print('places:');
    for (var place in jsonResponse) {
      all.write(place['_id'], place);
    }
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

  bool filterPolygons(String placeId) {
    return store.places.all.read(placeId)['polygon'].length > 1;
  }

  bool filterMarkers(String placeId) {
    return store.places.all.read(placeId)['polygon'].length == 1;
  }

  List<Polygon> get polygons {
    return List<Polygon>.from(store.places.all
        .getKeys()
        .where(filterPolygons)
        .map((placeId) => Polygon(
            points: List<LatLng>.from(store.places.all
                .read(placeId)['polygon']
                .map((point) => LatLng(point[0], point[1]))
                .toList()),
            color: Colors.red))
        .toList());
  }

  List<Marker> get markers {
    return List<Marker>.from(store.places.all.getKeys().where(filterMarkers).map((placeId) {
      final place = store.places.all.read(placeId);
      print(place);
      return IPlaceMarker(
          id: place['_id'],
          title: place['name'][store.lang.lang.value],
          vicinity: "vicinity",
          lat: place['polygon'][0][0],
          long: place['polygon'][0][1],
          icon: Icons.place);
    }).toList());
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
