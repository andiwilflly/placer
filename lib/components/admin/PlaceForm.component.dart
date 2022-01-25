import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:placer/components/_parts/Input.component.dart';
import 'package:placer/models/palceForm.model.dart';
import 'package:placer/models/store.dart';

class PlaceForm extends StatefulWidget {
  const PlaceForm({Key? key}) : super(key: key);

  @override
  PlaceFormState createState() {
    return PlaceFormState();
  }
}

class PlaceFormState extends State<PlaceForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final myString = placesFormModel.form["name"]!["test"];

    JsonEncoder encoder = new JsonEncoder.withIndent('  ');

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          for (var lang in store.lang.languages.keys)
            Column(children: [
              SizedBox(height: 5),
              Input(
                  hintText: 'Name ($lang)',
                  onChanged: (text) {
                    // placesForm["name"]![lang] = text;
                    // print(placesForm);
                  })
            ]),
          SizedBox(height: 20),
          for (var lang in store.lang.languages.keys)
            Column(children: [
              SizedBox(height: 5),
              Input(
                  hintText: 'Description ($lang)',
                  maxLines: 5,
                  onChanged: (text) {
                    // placesForm["description"]![lang] = text;
                    // print(placesForm);
                  })
            ]),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
              print(_formKey.currentState);
            },
            child: Text('Submit'.tr),
          ),
          // Obx(() => Text(encoder.convert(placesForm)))
        ],
      ),
    );
  }
}
