import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flag/flag.dart';
import 'package:placer/components/LangSelection.component.dart';
import 'package:placer/components/Login.component.dart';
import 'package:placer/components/_parts/PreLoader.component.dart';
import 'package:placer/models/store.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Layout extends StatelessWidget {
  const Layout({
    Key? key,
    required this.children,
  }) : super(key: key);

  final Widget children;

  Widget renderAuthPage(BuildContext context) {
    return Stack(children: [
      children,
      Positioned(
          left: 30.0,
          top: 45.0,
          child: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: IconButton(
              icon: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.white)),
                child: Flag.fromCode(
                  store.lang.languages[store.lang.lang.toString()]['icon'],
                  height: 15,
                  width: 20,
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
            ),
          )),
      Obx(() => store.auth.isAdmin.value == true && kIsWeb == true
          ? new Positioned(
              left: 100.0,
              top: 45.0,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey,
                child: IconButton(
                  icon: Icon(
                    Get.currentRoute == '/home' ? Icons.admin_panel_settings : Icons.map_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.currentRoute == '/home' ? Get.toNamed('/admin') : Get.back();
                  },
                ),
              ),
            )
          : Column(children: [])),
      Obx(() => new Positioned(
            left: store.auth.isAdmin.value == true && kIsWeb == true ? 170 : 100,
            top: 45.0,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blueGrey,
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  store.auth.logOut();
                },
              ),
            ),
          ))
    ]);
  }

  // LANG TO LAYOUT
  // TOP MENU LAYOUT?
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => store.isProjectReady == true
            ? store.auth.isAuth.value == true
                ? renderAuthPage(context)
                : LoginPage()
            : PreLoader()));
  }
}
