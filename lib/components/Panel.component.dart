import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';
import 'package:placer/components/Map.component.dart';

class Panel extends StatefulWidget {
  @override
  _SlidePanel createState() => _SlidePanel();
}

class _SlidePanel extends State<Panel> {
  PanelController panelController = new PanelController();

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
        child: SlidingUpPanel(
            controller: panelController,
            minHeight: 80,
            maxHeight: deviceHeight / 100 * 80,
            snapPoint: 0.5,
            color: Colors.white,
            renderPanelSheet: true,
            parallaxEnabled: true,
            onPanelClosed: () {},
            margin: EdgeInsets.only(left: 2, right: 2),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            panel: Container(
              transform: Matrix4.translationValues(0.0, -40.0, 0.0),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    bottom: TabBar(
                      onTap: (index) {},
                      indicatorColor: Colors.white,
                      unselectedLabelColor: Colors.black26,
                      labelColor: Colors.black,
                      tabs: [
                        Tab(icon: Icon(Icons.list, size: 30)),
                        Tab(icon: Icon(Icons.settings, size: 30)),
                        Tab(icon: Icon(Icons.person, size: 30)),
                      ],
                    )),
                body: TabBarView(
                  children: [
                    Icon(Icons.directions_car),
                    Icon(Icons.settings),
                    Icon(Icons.person),
                  ],
                ),
              ),
            ),
            body: Map()),
        length: 3);
  }
}
