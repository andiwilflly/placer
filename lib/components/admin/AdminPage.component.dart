import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placer/components/admin/PlaceForm.component.dart';
import 'package:placer/models/placeForm.model.dart';
import 'dart:convert';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');

    return Row(
      children: <Widget>[
        Expanded(
          // It takes 5/6 part of the screen
          flex: 3,
          child: PlaceForm(),
        ),
        Expanded(
          // It takes 5/6 part of the screen
          flex: 3,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Obx(() => Text(encoder.convert(placesFormModel.form))),
              )
            ],
          ),
        ),
      ],
    );
  }
}
