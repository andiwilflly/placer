import 'package:get/get.dart';
import "package:placer/models/lang.model.dart";
import 'package:placer/notifications/init.notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Store {
  RxBool isProjectReady = false.obs;
  RxBool isAppInForeground = true.obs;

  // Local notifications
  final notifications = Notifications();


  // Models
  final lang = LangModel();

  void setIsAppInForeground(bool isForeground) {
    isAppInForeground.value = isForeground;
  }
}

final store = Store();
