import 'package:flutter/material.dart';

class PreLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(children: [CircularProgressIndicator()], mainAxisAlignment: MainAxisAlignment.center)
    ]);
  }
}
