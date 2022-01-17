import 'package:get/get.dart';
import "package:placer/models/lang.model.dart";

class Store {
  RxBool isProjectReady = false.obs;
  RxBool isAppInForeground = true.obs;

  // Models
  final lang = LangModel();

  void setIsAppInForeground(bool isForeground) {
    isAppInForeground.value = isForeground;
  }
}

final store = Store();
