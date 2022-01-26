import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:placer/components/_parts/Input.component.dart';
import 'package:placer/models/placeForm.model.dart';

class CreatePolygonMap extends StatefulWidget {
  @override
  CreatePolygonMapState createState() => CreatePolygonMapState();
}

class CreatePolygonMapState extends State<CreatePolygonMap> {
  late MapController controller;
  late List<LatLng> _polygon;
  late bool _isShowMarkers;

  RxMap form = {
    'lat': placesFormModel.form['polygon'][0].latitude,
    'long': placesFormModel.form['polygon'][0].longitude,
    'isDrawPolygon': false,
    'polygonColor': Colors.amberAccent.withOpacity(0.4),
    'polygonDotColor': Colors.orange,
    'polygonDotSize': 2,
  }.obs;

  void initState() {
    super.initState();
    controller = MapController();

    setState(() {
      _polygon = placesFormModel.form['polygon'];
      _isShowMarkers = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            constraints: BoxConstraints(minHeight: 400, maxHeight: 400),
            child: FlutterMap(
              mapController: controller,
              options: MapOptions(
                  center: LatLng(form['lat'], form['long']),
                  zoom: 16,
                  maxZoom: 18.25,
                  interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                  plugins: [],
                  onTap: (TapPosition, latLng) {
                    print(latLng.latitude);
                    print(latLng.longitude);
                    print(json.encode(LatLng(latLng.longitude, latLng.latitude)));
                    print(json.encode(latLng));

                    setState(() {
                      _polygon.add(latLng);
                    });
                    placesFormModel.form['polygon'] = _polygon;
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
                PolygonLayerOptions(polygons: [Polygon(points: _polygon, color: form['polygonColor'])]),
                MarkerLayerOptions(
                  markers: [
                    for (var latLng in _polygon)
                      Marker(
                        width: _isShowMarkers == true ? form['polygonDotSize'] : 0,
                        height: _isShowMarkers == true ? form['polygonDotSize'] : 0,
                        point: latLng,
                        builder: (ctx) => Container(
                          decoration: BoxDecoration(
                              color: form['polygonDotColor'],
                              border: Border.all(
                                color: form['polygonDotColor'],
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(form['polygonDotSize']))),
                        ),
                      ),
                  ],
                ),
              ],
            )),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(children: [
                OutlinedButton.icon(
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
                )
              ]),
            ),
            Expanded(
              flex: 1,
              child: Obx(() => placesFormModel.form['polygon'].length != 0
                  ? OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        placesFormModel.form['polygon'].clear();
                        setState(() {
                          _polygon = [];
                        });
                      },
                      icon: Icon(Icons.delete),
                      label: Text("Remove polygon".tr),
                    )
                  : Row(children: [])),
            ),
          ],
        )
      ],
    );
  }
}
