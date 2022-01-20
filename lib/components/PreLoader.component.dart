import 'package:flutter/material.dart';

class PreLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: CircularProgressIndicator(
        value: 0.3,
        backgroundColor: Colors.cyanAccent,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
  }
}
