import 'package:flutter/material.dart';
import 'package:placer/components/MapControlButtons.component.dart';
import 'package:placer/components/Panel.component.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [Panel(), MapControlButtons()]);
  }
}
