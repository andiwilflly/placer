import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:placer/components/place/PlaceCarousel.component.dart';
import 'package:placer/components/place/PlaceHistory.component.dart';
import 'package:get/get.dart';
import 'package:placer/models/store.dart';

class PlaceCardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedPlace = store.places.selectedPlace;
    print('selectedPlace');
    print(store.places.all[store.selectedPlaceId.value]);

    return Obx(() => Column(children: [
          Text(store.selectedPlaceId.value),
          Text(selectedPlace['_id']),
          Padding(
              child: Row(children: [Text(selectedPlace['name'][store.lang.lang.value])]),
              padding: EdgeInsets.symmetric(horizontal: 20)),
          Padding(
              child: Row(children: [Text(selectedPlace['address'])]),
              padding: EdgeInsets.symmetric(horizontal: 20))
        ]));
  }
}

class PlaceCardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[PlaceCarousel(), PlaceHistory()]);
  }
}

Map PlaceCard = {'Header': PlaceCardHeader(), 'Body': PlaceCardBody()};
