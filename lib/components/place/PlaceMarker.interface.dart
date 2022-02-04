import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IPlaceMarker extends Marker {
  IPlaceMarker(
      {required this.id,
      required this.lat,
      required this.title,
      required this.long,
      required this.vicinity,
      required this.icon})
      : super(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          height: 25,
          width: 25,
          point: LatLng(lat, long),
          builder: (BuildContext ctx) => GestureDetector(
            onTap: () {
              Get.back();
              Get.snackbar(
                title,
                vicinity,
                icon: Icon(icon),
                // titleText: Text(title),
                mainButton: TextButton(child: Text('Close'), onPressed: () => Get.back()),
                onTap: (_) => {},
                duration: Duration(seconds: 10),
                animationDuration: Duration(milliseconds: 300),
                snackPosition: SnackPosition.TOP,
              );
            },
            child: ClipRRect(borderRadius: BorderRadius.circular(3), child: Icon(icon)),
          ),
        );

  final String id;
  final IconData icon;
  final String vicinity;
  final String title;
  final double lat;
  final double long;
}
