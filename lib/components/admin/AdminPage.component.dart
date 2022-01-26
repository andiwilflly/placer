import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placer/components/admin/CreatePolygonMap.component.dart';
import 'package:placer/components/admin/PlaceForm.component.dart';
import 'package:placer/models/placeForm.model.dart';
import 'dart:convert';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');

    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Column(children: [
                    CreatePolygonMap(),
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
