import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:placer/components/Login.component.dart';
import 'package:placer/components/MapControlButtons.component.dart';
import 'package:placer/components/Panel.component.dart';
import 'package:placer/components/admin/AdminPage.component.dart';
import 'package:placer/models/store.dart';
import 'package:placer/translations.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  store.auth.firebaseAuthStateChanges();

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

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    store.setIsAppInForeground(state == AppLifecycleState.resumed);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => store.isProjectReady == true
        ? store.auth.isAuth == true
            ? Scaffold(
                body: Stack(children: <Widget>[
                kIsWeb ? AdminPage() : Panel(),
                kIsWeb ? Column(children: <Widget>[]) : MapControlButtons()
              ]))
            : LoginPage()
        : Center(child: CircularProgressIndicator()));
  }
}
