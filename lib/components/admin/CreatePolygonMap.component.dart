import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:placer/components/_parts/Input.component.dart';

class CreatePolygonMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(children: [
          Expanded(
            flex: 3,
            child: Input(hintText: 'Latitude'.tr, onChanged: (text) {}),
          ),
          Expanded(
            flex: 3,
            child: Input(hintText: 'Longitude'.tr, onChanged: (text) {}),
          ),
          Expanded(
            flex: 6,
            child: SizedBox.shrink(),
          ),
        ]),
        SizedBox(height: 10),
        ConstrainedBox(
            constraints: BoxConstraints(minHeight: 400, maxHeight: 400),
            child: FlutterMap(
              // mapController: store.map.controller,
              options: MapOptions(
                  center: LatLng(50.4402216, 30.5170319),
                  zoom: 16,
                  minZoom: 12,
                  maxZoom: 18,
                  interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                  plugins: [],
                  onPositionChanged: (MapPosition, bool) {}),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
              ],
            ))
      ],
    );
  }
}