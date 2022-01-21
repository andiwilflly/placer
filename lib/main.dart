import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:placer/components/MapControlButtons.component.dart';
import 'package:placer/components/Panel.component.dart';
import 'package:placer/models/store.dart';
import 'package:placer/translations.dart';
import 'package:placer/utils/responsive.utils.dart';

void main() async {
  await GetStorage.init();
  store.lang.setLang(Get.deviceLocale.toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'placer',
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

    store.location.init();
    store.notifications.init();
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
        body: Stack(children: <Widget>[
      Responsive.isDesktop(context) ? Text('hello'.tr) : Panel(),
      MapControlButtons()
    ]));
  }
}
