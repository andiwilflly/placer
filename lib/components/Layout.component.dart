import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flag/flag.dart';
import 'package:placer/components/LangSelection.component.dart';
import 'package:placer/components/Login.component.dart';
import 'package:placer/components/_parts/LangIcon.component.dart';
import 'package:placer/components/_parts/PreLoader.component.dart';
import 'package:placer/components/place/PlacesSearch.component.dart';
import 'package:placer/models/store.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Layout extends StatelessWidget {
  const Layout({
    Key? key,
    required this.children,
  }) : super(key: key);

  final Widget children;

  Widget renderAuthPage(BuildContext context) {
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            leading: LangIcon(),
            elevation: 0,
            actions: [
              IconButton(
                  splashRadius: 0.1,
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print('saerch');
                    showSearch(
                      context: context,
                      delegate: PlacesSearch(),
                    );
                  }),
              Obx(() => store.auth.isAdmin.value == true && kIsWeb == true
                  ? IconButton(
                      splashRadius: 0.1,
                      icon: Icon(
                          Get.currentRoute == '/home' ? Icons.admin_panel_settings : Icons.map_outlined),
                      onPressed: () {
                        Get.currentRoute == '/home' ? Get.toNamed('/admin') : Get.back();
                      })
                  : Column(children: [])),
              Obx(() => store.auth.isAuth == true
                  ? IconButton(splashRadius: 0.1, icon: Icon(Icons.logout), onPressed: store.auth.logOut)
                  : Row(children: [])),
            ],
            backgroundColor: Colors.transparent),
        body: Obx(() => store.isProjectReady == true
            ? store.auth.isAuth.value == true
                ? renderAuthPage(context)
                : LoginPage()
            : PreLoader()));
  }
}
