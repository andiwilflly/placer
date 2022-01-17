import 'package:flutter/material.dart';
import 'package:placer/components/panel.component.dart';
import 'package:placer/utils/responsive.utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hidden places',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(children: <Widget>[
      Responsive.isDesktop(context) ? Text('DESKTOP') : Panel(),
      new Positioned(
          right: 15.0,
          top: 15.0,
          child: IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            iconSize: 30,
            onPressed: () {},
          )),
    ]));
  }
}
