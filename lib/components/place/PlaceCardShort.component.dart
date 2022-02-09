import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:placer/models/places/place.model.dart';
import 'package:placer/models/store.dart';

class PlaceCardShort extends StatefulWidget {
  final String placeId;

  const PlaceCardShort({Key? key, required this.placeId}) : super(key: key);

  @override
  PlaceCardShortState createState() => PlaceCardShortState();
}

class PlaceCardShortState extends State<PlaceCardShort> {
  @override
  Widget build(BuildContext context) {
    final Rx<IPlace> place = store.places.find(widget.placeId);
    return Column(children: [Text(place.value.name[store.lang.lang.value])]);
  }
}
