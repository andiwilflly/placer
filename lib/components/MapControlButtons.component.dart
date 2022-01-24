import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flag/flag.dart';
import 'package:placer/models/store.dart';
import 'package:latlong2/latlong.dart';
import 'package:placer/components/LangSelection.component.dart';

class MapControlButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      new Positioned(
          right: 15.0,
          top: 35.0,
          child: IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search'.tr,
            iconSize: 30,
            onPressed: () async {
              store.notifications.send('hehe', 'net?');
            },
          )),
      new Positioned(
          right: 15.0,
          top: 85.0,
          child: IconButton(
            icon: const Icon(Icons.api),
            iconSize: 30,
            onPressed: () {
              store.map.controller.move(
                  LatLng(store.location.lat.value, store.location.long.value),
                  store.map.zoom.value);
            },
          )),
      new Positioned(
          left: 15.0,
          top: 35.0,
          child: IconButton(
            icon: Flag.fromCode(
              store.lang.languages[store.lang.lang.toString()]['icon'],
              height: 20,
              width: 25,
              fit: BoxFit.fill,
              borderRadius: 5,
            ),
            tooltip: "Select language".tr,
            iconSize: 30,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return LangSelection();
                  });
            },
          ))
    ]);
  }
}
