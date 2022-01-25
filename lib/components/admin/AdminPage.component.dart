import 'package:flutter/material.dart';
import 'package:placer/components/admin/PlaceForm.component.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              Text('json')
            ],
          ),
        ),
      ],
    );
  }
}
