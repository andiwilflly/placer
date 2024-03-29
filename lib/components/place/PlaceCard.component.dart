import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:placer/components/place/PlaceCarousel.component.dart';
import 'package:placer/components/place/PlaceHistory.component.dart';
import 'package:get/get.dart';
import 'package:placer/models/places/place.model.dart';
import 'package:placer/models/store.dart';

Map PlaceCard = {'Header': PlaceCardHeader(), 'Body': PlaceCardBody()};

class PlaceCardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(children: [
          Padding(
              child: Row(children: [Text(store.places.selectedPlace.value.name[store.lang.lang.value])]),
              padding: EdgeInsets.symmetric(horizontal: 20)),
          Padding(
              child: Row(children: [Text(store.places.selectedPlace.value.address)]),
              padding: EdgeInsets.symmetric(horizontal: 20)),
          Padding(
              child: Row(children: [Text('distance: ${store.places.selectedPlace.value.distance} meters')]),
              padding: EdgeInsets.symmetric(horizontal: 20)),
        ]));
  }
}

class PlaceCardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[PlaceCarousel(), PlaceHistory()]);
  }
}
