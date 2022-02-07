import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:placer/components/place/PlaceCarousel.component.dart';
import 'package:placer/components/place/PlaceHistory.component.dart';
import 'package:placer/models/store.dart';
import 'package:latlong2/latlong.dart';
import 'package:placer/components/LangSelection.component.dart';

class PlaceCardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          child: Row(children: [Text('Place.title')]), padding: EdgeInsets.symmetric(horizontal: 20)),
      Padding(
          child: Row(children: [Text('Place.address')]), padding: EdgeInsets.symmetric(horizontal: 20))
    ]);
  }
}

class PlaceCardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[PlaceCarousel(), PlaceHistory()]);
  }
}

Map PlaceCard = {'Header': PlaceCardHeader(), 'Body': PlaceCardBody() };
