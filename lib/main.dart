import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placer/components/Layout.component.dart';
import 'package:placer/components/pages/AdminPage.component.dart';
import 'package:placer/components/pages/HomePage.component.dart';
import 'package:placer/models/store.dart';
import 'package:placer/services/background.service.dart';
import 'package:placer/translations.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

// TODO: Fix cocoa pods:
// For me this was resolved by opening the Android studio from terminal
// open /Applications/Android\ Studio.app

// flutter build web --web-renderer html/canvaskit
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  store.auth.firebaseAuthStateChanges();

  initializeBackgroundService();

  store.lang
      .setLang(store.lang.languages[Get.deviceLocale] != null ? Get.deviceLocale.toString() : 'en_US');

  // await DotEnv().load();
  // await dotenv.load(fileName: ".env");
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
    print(state);
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
        debugShowCheckedModeBanner: false,
        title: 'placer.io',
        theme: ThemeData(primarySwatch: Colors.orange),
        translations: Messages(),
        locale: store.lang.languages[Get.deviceLocale] != null ? Get.deviceLocale : Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
        initialRoute: '/home',
        getPages: [
          GetPage(
              name: '/home', page: () => Layout(children: HomePage()), transition: Transition.native),
          GetPage(
              name: '/admin', page: () => Layout(children: AdminPage()), transition: Transition.native)
        ]);
  }
}
