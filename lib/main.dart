import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:placer/components/Layout.component.dart';
import 'package:placer/components/pages/AdminPage.component.dart';
import 'package:placer/components/pages/HomePage.component.dart';
import 'package:placer/models/store.dart';
import 'package:placer/translations.dart';
import 'package:flutter/services.dart';
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
    return Router();
  }
}

class Router extends StatefulWidget {
  @override
  State<Router> createState() => RouterState();
}

class RouterState extends State<Router> with WidgetsBindingObserver {
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
    return GetMaterialApp(
        title: 'placer.io',
        theme: ThemeData(primarySwatch: Colors.orange),
        translations: Messages(),
        locale: Get.deviceLocale,
        fallbackLocale: Locale('uk', 'UA'),
        initialRoute: '/home',
        getPages: [
          GetPage(name: '/home', page: () => Layout(children: HomePage())),
          GetPage(name: '/admin', page: () => Layout(children: AdminPage()))
        ]);
  }
}
