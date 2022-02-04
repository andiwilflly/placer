import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:placer/components/_parts/Input.component.dart';
import 'package:placer/components/place/PlaceMarker.component.dart';
import 'package:placer/models/placeForm.model.dart';

class CreatePolygonMap extends StatefulWidget {
  @override
  CreatePolygonMapState createState() => CreatePolygonMapState();
}

class CreatePolygonMapState extends State<CreatePolygonMap> {
  late MapController controller;

  // late List<LatLng> _polygon;
  late bool _isShowMarkers;

  RxMap form = {
    'lat': placesFormModel.getPolygon()[0].latitude,
    'long': placesFormModel.getPolygon()[0].longitude,
    'isDrawPolygon': false,
    'polygonColor': Colors.blue.withOpacity(0.4),
    'polygonDotColor': Colors.blue,
    'polygonDotSize': 2,
  }.obs;

  void initState() {
    super.initState();
    controller = MapController();

    setState(() {
      _isShowMarkers = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: 10),
        Row(children: [
          Expanded(
            flex: 3,
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Input(
                    hintText: 'Latitude'.tr,
                    onChanged: (text) {
                      form['lat'] = double.parse(text!);
                    })),
          ),
          Expanded(
            flex: 3,
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Input(
                    hintText: 'Longitude'.tr,
                    onChanged: (text) {
                      form['long'] = double.parse(text!);
                    })),
          ),
          Expanded(
            flex: 3,
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                    ),
                    onPressed: () {
                      if (form['lat'] is double && form['long'] is double) {
                        controller.move(LatLng(form['lat'], form['long']), 16);
                      }
                    },
                    icon: Icon(Icons.search),
                    label: Text("Search".tr))),
          ),
        ]),
        SizedBox(height: 10),
        ConstrainedBox(
            constraints: BoxConstraints(minHeight: deviceHeight * 0.5, maxHeight: deviceHeight * 0.5),
            child: Obx(() => FlutterMap(
                  mapController: controller,
                  options: MapOptions(
                      center: LatLng(form['lat'], form['long']),
                      zoom: 16,
                      maxZoom: 18.25,
                      interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                      plugins: [],
                      onTap: (TapPosition, latLng) {
                        placesFormModel.form['polygon'].add([latLng.latitude, latLng.longitude]);
                      },
                      onPositionChanged: (MapPosition, bool) {
                        // form['lat'] = MapPosition.center?.latitude;
                        // form['long'] = MapPosition.center?.longitude;
                      }),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'https://api.maptiler.com/maps/basic/{z}/{x}/{y}.png?key=SV4PDbJaQYJ2HfGi9vzA',
                      // 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      // 'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                      attributionBuilder: (_) {
                        return Obx(() => Text(form['lat'].toString() + ' / ' + form['long'].toString()));
                      },
                    ),
                    PolygonLayerOptions(polygons: [
                      Polygon(points: placesFormModel.getPolygon(), color: form['polygonColor'])
                    ]),
                    MarkerLayerOptions(
                      markers: placesFormModel.form['polygon'].length == 1
                          ? [
                              IPlaceMarker(
                                  id: 'ID',
                                  title: 'NAME',
                                  vicinity: "vicinity",
                                  lat: placesFormModel.form['polygon'][0][0],
                                  long: placesFormModel.form['polygon'][0][1],
                                  icon: Icons.place)
                            ]
                          : [
                              for (var latLng in placesFormModel.form['polygon'])
                                Marker(
                                  width: _isShowMarkers == true ? form['polygonDotSize'] : 0,
                                  height: _isShowMarkers == true ? form['polygonDotSize'] : 0,
                                  point: LatLng(latLng[0], latLng[1]),
                                  builder: (ctx) => Container(
                                    decoration: BoxDecoration(
                                        color: form['polygonDotColor'],
                                        border: Border.all(
                                          color: form['polygonDotColor'],
                                        ),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(form['polygonDotSize']))),
                                  ),
                                ),
                            ],
                    ),
                  ],
                ))),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () {
                  setState(() {
                    _isShowMarkers = !_isShowMarkers;
                  });
                },
                icon: Icon(Icons.place),
                label: _isShowMarkers == true ? Text("Hide markers".tr) : Text("Show markers".tr),
              ),
            ),
            Expanded(
              flex: 2,
              child: Obx(() => placesFormModel.form['polygon'].length != 0
                  ? OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        placesFormModel.form['polygon'].clear();
                      },
                      icon: Icon(Icons.delete),
                      label: Text("Remove polygon".tr),
                    )
                  : Row(children: [])),
            ),
            Expanded(
              flex: 1,
              child: Obx(() => placesFormModel.form['polygon'].length != 0
                  ? OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        placesFormModel.form['polygon'].removeLast();
                      },
                      icon: Icon(Icons.undo),
                      label: Text("Undo".tr),
                    )
                  : Row(children: [])),
            )
          ],
        ),
      ],
    );
  }
}
