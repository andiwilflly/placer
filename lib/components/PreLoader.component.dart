import 'package:flutter/material.dart';

class PreLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: CircularProgressIndicator(),
    );
  }
}
