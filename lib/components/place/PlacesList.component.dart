import 'package:flutter/material.dart';
import 'package:placer/components/place/PlaceCardShort.component.dart';
import 'package:placer/models/places/place.model.dart';

class PlacesList extends StatelessWidget {
  final List<IPlace> places;

  PlacesList({Key? key, required this.places}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemCount: places.length,
        itemBuilder: (BuildContext context, int index) {
          return PlaceCardShort(placeId: places[index].id);
        });
  }
}
