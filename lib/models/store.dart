import 'package:get/get.dart';
import 'package:placer/models/auth.model.dart';
import "package:placer/models/lang.model.dart";
import 'package:placer/models/location.model.dart';
import 'package:placer/models/map.model.dart';
import 'package:placer/models/places/places.model.dart';
import 'package:placer/services/notifications.service.dart';

class Store {
  RxBool isProjectReady = false.obs;
  RxBool isAppInForeground = true.obs;

  // Local notifications
  final notifications = NotificationsModel();

  // Models
  final auth = AuthModel();
  final lang = LangModel();
  final location = LocationModel();
  final map = MapModel();
  final places = PlacesModel();

  void setIsAppInForeground(bool isForeground) {
    isAppInForeground.value = isForeground;
  }

  void setProjectReady() {
    isProjectReady.value = true;
  }
}

final store = Store();
