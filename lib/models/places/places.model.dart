import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:placer/components/place/PlaceMarker.component.dart';
import 'package:placer/models/places/place.model.dart';
import 'dart:convert' as convert;
import 'package:placer/models/store.dart';
import 'package:placer/utils/isPointInPolygon.utils.dart';

// final String? HOST = DotEnv().env['SERVER_HOST'];
final String? HOST = 'http://localhost';
// final String? PORT = DotEnv().env['SERVER_PORT'];
final String? PORT = '4000';

class PlacesModel {
  final RxList all = [].obs;

  find(String placeId) => all.firstWhere((place) => place.value.id == placeId, orElse: () => null);

  get selectedPlace {
    return all.firstWhere((place) => place.value.isSelected, orElse: () => null);
  }

  dynamic selectPlace(String? placeId) {
    all.forEach((place) {
      place.update((place) => place.isSelected = place.id == placeId);
    });
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

    for (var placeObj in jsonResponse) {
      final Rx<IPlace> place = IPlace(
        id: placeObj['_id'],
        name: placeObj['name'],
        description: placeObj['description'],
        address: placeObj['address'],
        images: placeObj['images'],
        videos: placeObj['videos'],
        polygon: placeObj['polygon'],
      ).obs;
      all.add(place);
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

  bool filterPolygons(dynamic place) => place.value.polygon.length > 1;
  bool filterMarkers(dynamic place) => place.value.polygon.length == 1;

  Polygon toPolygon(Rx<IPlace> place) => Polygon(
      points: List<LatLng>.from(place.value.polygon.map((point) => LatLng(point[0], point[1])).toList()),
      color: Colors.red);

  String? getPlaceIdByLatLng(LatLng latLng) {
    final place = all.firstWhere((place) {
      return isPointInPolygon(latLng, toPolygon(place));
    }, orElse: () => null);
    return place == null ? null : place.value.id;
  }

  List<Polygon> get polygons {
    return List<Polygon>.from(all.where(filterPolygons).map((place) {
      return toPolygon(place);
    }).toList());
  }

  List<Marker> get markers {
    return List<Marker>.from(all.where(filterMarkers).map((place) {
      return IPlaceMarker(
          id: place.value.id,
          title: place.value.name[store.lang.lang.value],
          vicinity: "vicinity",
          lat: place.value.polygon[0][0],
          long: place.value.polygon[0][1],
          icon: Icons.place);
    }).toList());
  }
}
