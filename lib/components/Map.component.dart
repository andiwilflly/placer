import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:placer/models/store.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

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
    return new Stack(children: <Widget>[
      FlutterMap(
        mapController: store.map.controller,
        options: MapOptions(
            center: LatLng(store.location.lat.value, store.location.long.value),
            zoom: store.map.zoom.value,
            minZoom: 12,
            maxZoom: 18,
            interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            plugins: [
              //LocationMarkerPlugin(),
            ],
            onPositionChanged: (MapPosition, bool) {
              store.map.updateZoom(MapPosition.zoom!);
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
          // LocationMarkerLayerOptions(
          //   marker: DefaultLocationMarker(),
          //   headingSectorRadius: 70,
          // ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 20.0,
                height: 20.0,
                point:
                    LatLng(store.location.lat.value, store.location.long.value),
                builder: (ctx) => Container(
                  child: FlutterLogo(),
                ),
              ),
            ],
          ),
        ],
      )
    ]);
  }
}
