import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(50.45466, 30.5238),
        zoom: 14,
        minZoom: 12,
        maxZoom: 18,
        interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        plugins: [
          LocationMarkerPlugin(),
        ],
      ),
      layers: [
        TileLayerOptions(
          // urlTemplate: 'http://a.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
          urlTemplate: 'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
          // 'https://tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png',
          // 'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
          // 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        LocationMarkerLayerOptions(
          marker: DefaultLocationMarker(),
          headingSectorRadius: 70,
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) => Container(
                child: FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}