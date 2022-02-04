import 'package:placer/components/_parts/PreLoader.component.dart';
import 'package:placer/components/_parts/Search.component.dart';
import 'package:placer/components/place/PlaceCard.component.dart';
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
  PanelController panelController = new PanelController();

  @override
  void initState() {
    store.places.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
        child: SlidingUpPanel(
            controller: panelController,
            minHeight: 100,
            maxHeight: deviceHeight * 0.8,
            // snapPoint: 0.5,
            color: Colors.white,
            renderPanelSheet: true,
            panelSnapping: true,
            // parallaxEnabled: true,
            onPanelClosed: () {},
            margin: EdgeInsets.only(left: 0, right: 0),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            panel: SingleChildScrollView(
                child: Container(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                      child: Container(
                          height: 5,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), color: Colors.black26)),
                    )
                  ],
                ),
                Search(),
                SizedBox(height: 10),
                PlaceCard()
              ]),
            )),
            body: Obx(() => store.location.lat.value != 0.0 ? Map() : Map())),
        length: 3);
  }
}
