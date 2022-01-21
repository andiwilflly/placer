import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:get/get.dart';
import 'package:placer/models/store.dart';

class LangSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (var lang in store.lang.languages.keys)
          new Container(
              decoration: lang == store.lang.lang.value
                  ? new BoxDecoration(color: Colors.black12)
                  : null,
              child: ListTile(
                leading: Flag.fromCode(
                  store.lang.languages[lang]['icon'],
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                  borderRadius: 5,
                ),
                title: new Text(store.lang.languages[lang]['name']),
                onTap: () {
                  store.lang.setLang(lang);
                  Navigator.pop(context);
                  Get.updateLocale(store.lang.languages[lang]['code']);
                },
              ))
      ],
    ));
  }
}
