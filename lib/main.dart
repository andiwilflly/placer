import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placer/components/LangSelection.component.dart';
import 'package:placer/components/Panel.component.dart';
import 'package:placer/models/store.dart';
import 'package:placer/translations.dart';
import 'package:placer/utils/responsive.utils.dart';

void main() {
  store.lang.setLang(Get.deviceLocale.toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hidden places',
      theme: ThemeData(primarySwatch: Colors.blue),
      translations: Messages(),
      locale: Get.deviceLocale,
      // translations will be displayed in that locale
      fallbackLocale: Locale('ua', 'UA'),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    store.setIsAppInForeground(state == AppLifecycleState.resumed);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(children: <Widget>[
      Responsive.isDesktop(context) ? Text('hello'.tr) : Panel(),
      new Positioned(
          right: 15.0,
          top: 35.0,
          child: IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search'.tr,
            iconSize: 30,
            onPressed: () {},
          )),
      new Positioned(
          left: 15.0,
          top: 35.0,
          child: IconButton(
            icon: const Icon(Icons.language),
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
    ]));
  }
}
