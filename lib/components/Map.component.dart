import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:placer/models/store.dart';
import 'package:placer/utils/isPointInPolygon.utils.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  void initState() {
    super.initState();
    store.map.updateController(MapController());
  }

  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Obx(() => FlutterMap(
            mapController: store.map.controller,
            options: MapOptions(
                // center: LatLng(store.location.lat.value, store.location.long.value),
                center: LatLng(50.4402216, 30.5170319),
                zoom: store.map.zoom.value,
                minZoom: 12,
                maxZoom: 18,
                interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                plugins: [],
                onTap: (tapPos, LatLng latLng) {
                  store.setSelectedPlaceId(store.places.getPlaceIdByLatLng(latLng));
                },
                onPositionChanged: (MapPosition, bool) {
                  //store.map.updateZoom(MapPosition.zoom!);
                  // print(store.map.zoom.value);
                }),
            layers: [
              TileLayerOptions(
                // urlTemplate: 'http://a.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
                urlTemplate:
                    'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
                // 'https://tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png',
                // 'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
                // 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              PolygonLayerOptions(polygons: store.places.polygons),
              MarkerLayerOptions(markers: store.places.markers),
            ],
          ))
    ]);
  }
}
