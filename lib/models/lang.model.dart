import 'package:flag/flag.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LangModel {
  Map languages = {
    'en_EN': {'icon': FlagsCode.GB, 'name': 'EN', 'code': Locale('en', 'US')},
    'ua_UA': {'icon': FlagsCode.UA, 'name': 'UA', 'code': Locale('ua', 'UA')},
    'ru_RU': {'icon': FlagsCode.RU, 'name': 'RU', 'code': Locale('ru', 'RU')}
  };

  // List<String> languages = ['ru_RU', 'en_EN', 'ua_UA'];

  dynamic lang = ''.obs;

  void setLang(String newLang) {
    print('set lang: ${newLang}');
    lang.value = newLang;
  }
}
