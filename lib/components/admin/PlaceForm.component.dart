import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placer/components/_parts/Input.component.dart';
import 'package:placer/models/placeForm.model.dart';
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
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          for (var fieldName in placesFormModel.form.keys)
            Column(children: [
              placesFormModel.form[fieldName] is RxMap
                  ? Column(children: [
                      for (var lang in store.lang.languages.keys)
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Input(
                              hintText: '$fieldName/$lang',
                              onChanged: (text) {
                                placesFormModel.form[fieldName]![lang] = text;
                              }),
                        )
                    ])
                  : Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Input(
                          hintText: fieldName,
                          onChanged: (text) {
                            // placesForm["name"]![lang] = text;
                            // print(placesForm);
                          }))
            ]),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print('here!');
                print(placesFormModel.form);
                store.places.create(placesFormModel.form);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
              print(_formKey.currentState);
            },
            child: Text('Submit'.tr),
          )
        ],
      ),
    );
  }
}
