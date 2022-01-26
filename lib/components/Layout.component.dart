import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flag/flag.dart';
import 'package:placer/components/LangSelection.component.dart';
import 'package:placer/models/store.dart';

class Layout extends StatelessWidget {
  const Layout({
    Key? key,
    required this.children,
  }) : super(key: key);

  final Widget children;

  // LANG TO LAYOUT
  // TOP MENU LAYOUT?
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      new Positioned(
          left: 15.0,
          top: 35.0,
          child: IconButton(
            icon: Flag.fromCode(
              store.lang.languages[store.lang.lang.toString()]['icon'],
              height: 20,
              width: 25,
              fit: BoxFit.fill,
              borderRadius: 5,
            ),
            tooltip: "Select language".tr,
            iconSize: 30,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return LangSelection();
                  });
            },
          )),
      children
    ]));
  }
}
