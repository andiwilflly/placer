import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:placer/components/place/PlaceCarousel.component.dart';
import 'package:placer/models/store.dart';
import 'package:latlong2/latlong.dart';
import 'package:placer/components/LangSelection.component.dart';

class PlaceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      PlaceCarousel()
    ]);
  }
}
