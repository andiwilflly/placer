import 'package:location/location.dart';
import 'package:get/get.dart';

class LocationModel {
  Location location = new Location();

  RxDouble speed = 0.0.obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;

  init() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.enableBackgroundMode(enable: true);

    location.onLocationChanged.listen((LocationData currentLocation) {
      speed.value = currentLocation.speed!;
      lat.value = currentLocation.latitude!;
      long.value = currentLocation.longitude!;
    });
  }

  get() async {
    var l = await location.getLocation();

    speed.value = l.speed!;
    lat.value = l.latitude!;
    long.value = l.longitude!;

    return l;
  }
}
