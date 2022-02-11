import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placer/components/_parts/Input.component.dart';
import 'package:placer/models/placeForm.model.dart';
import 'package:placer/models/store.dart';
import 'package:placer/services/image.service.dart';
import 'package:placer/utils/uuid.utils.dart';

class PlaceForm extends StatefulWidget {
  const PlaceForm({Key? key}) : super(key: key);

  @override
  PlaceFormState createState() {
    return PlaceFormState();
  }
}

class PlaceFormState extends State<PlaceForm> {
  final _formKey = GlobalKey<FormState>();
  String placeUuid = generateUuid();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          for (var lang in store.lang.languages.keys)
            Padding(
                padding: EdgeInsets.only(top: 20),
                child: Input(
                    hintText: 'name/$lang',
                    onChanged: (text) {
                      placesFormModel.form['name'][lang] = text;
                    })),
          for (var lang in store.lang.languages.keys)
            Padding(
                padding: EdgeInsets.only(top: 20),
                child: Input(
                    hintText: 'description/$lang',
                    onChanged: (text) {
                      placesFormModel.form['description'][lang] = text;
                    })),
          SizedBox(height: 30),
          Obx(() => Column(children: [
                for (var imageUrl in placesFormModel.form['images'])
                  Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/placer-io.appspot.com/o/places%2F%5B%23cea3e%5D?alt=media&token=e0a4fcbd-b78b-4ae5-9cad-0c01a6671e5b')
              ])),
          ElevatedButton(
              onPressed: () async {
                String? imageUrl = await ImageService.uploadImageGallery(placeUuid);
                if (imageUrl == null) return;
                placesFormModel.form['images'].add(imageUrl);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Success!\n download image!',
                    ),
                  ),
                );
              },
              child: Text('Upload image'.tr)),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print('here!');
                print(placesFormModel.form);
                store.places.create(placesFormModel.form);
                placeUuid = generateUuid(); // Generate new
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
