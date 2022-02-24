import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placer/components/_parts/PreLoader.component.dart';
import 'package:placer/components/admin/CreatePolygonMap.component.dart';
import 'package:placer/components/admin/PlaceForm.component.dart';
import 'package:placer/models/placeForm.model.dart';
import 'dart:convert';

import 'package:placer/models/store.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');

    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Column(children: [
                    Obx(() => store.location.lat.value == 0.0 ? PreLoader() : CreatePolygonMap()),
                    PlaceForm()
                  ]),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: Obx(() => SelectableText(encoder.convert(placesFormModel.form))),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
