import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:placer/components/place/PlaceMarker.component.dart';
import 'dart:convert' as convert;
import 'package:placer/models/store.dart';
import 'package:placer/utils/isPointInPolygon.utils.dart';

// final String? HOST = DotEnv().env['SERVER_HOST'];
final String? HOST = 'http://localhost';
// final String? PORT = DotEnv().env['SERVER_PORT'];
final String? PORT = '4000';

class PlacesModel extends GetxController {
  final RxMap all = {}.obs;

  get selectedPlace {
    return all[store.selectedPlaceId.value];
  }

  void getAll() async {
    print('$HOST:$PORT/api/places');

    var response = await http.get(
      Uri.parse('$HOST:$PORT/api/places'),
      headers: {'Content-Type': 'application/json'},
    );
    var jsonResponse = convert.jsonDecode(response.body);

    print('places:');
    print(jsonResponse.length);

    all.addAll(Map.fromIterable(jsonResponse, key: (place) => place['_id'], value: (place) => place));
    // for (var place in jsonResponse) {
    //   all[place['_id']];
    // }
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

  bool filterPolygons(dynamic placeId) {
    return all[placeId]['polygon'].length > 1;
  }

  bool filterMarkers(dynamic placeId) {
    return all[placeId]['polygon'].length == 1;
  }

  String? getPlaceIdByLatLng(LatLng latLng) {
    final String placeId = all.value.keys.firstWhere((placeId) {
      final place = all[placeId];
      return isPointInPolygon(
          latLng,
          Polygon(
              points: List<LatLng>.from(
                  place['polygon'].map((point) => LatLng(point[0], point[1])).toList()),
              color: Colors.red));
    }, orElse: () => null);

    return placeId;
  }

  List<Polygon> get polygons {
    return List<Polygon>.from(all.value.keys
        .where(filterPolygons)
        .map((placeId) => Polygon(
            points: List<LatLng>.from(
                all[placeId]['polygon'].map((point) => LatLng(point[0], point[1])).toList()),
            color: Colors.red))
        .toList());
  }

  List<Marker> get markers {
    return List<Marker>.from(all.value.keys.where(filterMarkers).map((placeId) {
      final place = store.places.all[placeId];
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
  String _id = '';
  Map<String, String> name = {};
  Map<String, String> description = {};
  String address = '';
  List<String> images = [];
  List<String> videos = [];
  List<List<double>> polygon = [];
}
