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
// final String? HOST = 'http://localhost';
final String? HOST = 'http://167.71.12.148';
// final String? PORT = DotEnv().env['SERVER_PORT'];
final String? PORT = '4000';

class PlacesModel {
  RxString selectedPlaceId = ''.obs; // For subscription in Panel component
  final RxList all = <Rx<IPlace>>[].obs;

  find(String placeId) => all.firstWhere((place) => place.value.id == placeId, orElse: () => null);

  get selectedPlace {
    return all.firstWhere((place) => place.value.isSelected, orElse: () => null);
  }

  void selectPlace(String? placeId) {
    selectedPlaceId.value = placeId == null ? '' : placeId;
    all.forEach((place) {
      place.update((place) => place.isSelected = place.id == placeId);
    });

    if (placeId == null) return;
    IPlace place = store.places.selectedPlace.value;
    print(place.lat);
    print(store.map.zoom.value);
    store.map.controller.move(LatLng(place.lat * 0.99996, place.long), store.map.zoom.value);
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
        images: List<String>.from(placeObj['images']),
        videos: List<String>.from(placeObj['videos']),
        polygon: convertPolygon(placeObj['polygon']),
      ).obs;
      all.add(place);
      
    }
  }

  create(RxMap<dynamic, dynamic> place) async {
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

  List<List<double>> convertPolygon(List<dynamic> polygon) =>
      List<List<double>>.from(polygon.map((dynamic latLng) => List<double>.from(latLng)).toList());

  Polygon toPolygon(Rx<IPlace> place) => Polygon(
      points: List<LatLng>.from(place.value.polygon.map((point) => LatLng(point[0], point[1])).toList()),
      color: place.value.isSelected ? Colors.red : Colors.blueAccent);

  String? getPlaceIdByLatLng(LatLng latLng) {
    final place = all.firstWhere((place) {
      return isPointInPolygon(latLng, toPolygon(place));
    }, orElse: () => null);
    return place == null ? null : place.value.id;
  }

  List<IPlace> get closestPlaces {
    List<IPlace> places = List<IPlace>.from(all.map((place) => place.value).toList());
    places.sort((a, b) => a.distance.compareTo(b.distance));
    return places;
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
          lat: place.value.polygon[0][0],
          long: place.value.polygon[0][1],
          icon: Icons.place);
    }).toList());
  }
}
