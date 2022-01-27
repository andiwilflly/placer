import 'package:flag/flag.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:placer/components/LangSelection.component.dart';
import 'package:placer/models/store.dart';

class LangIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.white)),
        child: Flag.fromCode(
          store.lang.languages[store.lang.lang.toString()]['icon'],
          height: 23,
          width: 30,
          fit: BoxFit.fill,
          borderRadius: 5,
        ),
      ),
      tooltip: "Select language".tr,
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return LangSelection();
            });
      },
    );
  }
}
