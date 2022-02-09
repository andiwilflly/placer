import 'package:placer/components/_parts/PreLoader.component.dart';
import 'package:placer/components/_parts/Search.component.dart';
import 'package:placer/components/place/PlaceCard.component.dart';
import 'package:placer/components/place/PlacesList.component.dart';
import 'package:placer/models/store.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placer/components/Map.component.dart';

class Panel extends StatefulWidget {
  @override
  _SlidePanel createState() => _SlidePanel();
}

class _SlidePanel extends State<Panel> {
  late final selectedPlaceIdDisposer;
  PanelController panelController = new PanelController();

  @override
  void initState() {
    store.places.getAll();
    super.initState();

    selectedPlaceIdDisposer = store.places.selectedPlaceId.listen((selectedPlaceId) {
      panelController.animatePanelToPosition(selectedPlaceId == '' ? 0 : 0.4);
    });
  }

  @override
  void dispose() {
    selectedPlaceIdDisposer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    final double minPanelHeight = 80;

    return DefaultTabController(
        child: SlidingUpPanel(
            controller: panelController,
            minHeight: minPanelHeight,
            maxHeight: deviceHeight * 0.8,
            // snapPoint: 0.3,
            color: Colors.white,
            renderPanelSheet: true,
            panelSnapping: true,
            // parallaxEnabled: true,
            onPanelClosed: () {},
            margin: EdgeInsets.only(left: 0, right: 0),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            header: SizedBox(
                width: deviceWidth,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                      child: Container(
                          height: 5,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), color: Colors.black26)),
                    ),
                    Obx(() => store.places.selectedPlace == null ? Column() : PlaceCard['Header'])
                  ],
                )),
            panel: Padding(
                padding: EdgeInsets.only(top: minPanelHeight),
                child: SingleChildScrollView(
                    child: Container(
                  child: Obx(() => store.places.selectedPlace == null
                      ? Column(children: [PlacesList(places: store.places.closestPlaces)])
                      : Column(children: [PlaceCard['Body']])),
                ))),
            body: Obx(() => store.location.lat.value == 0.0 ? PreLoader() : Map())),
        length: 3);
  }
}
