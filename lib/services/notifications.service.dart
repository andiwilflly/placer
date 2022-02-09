import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsModel {
  late FlutterLocalNotificationsPlugin flutterNotificationPlugin;

  init() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterNotificationPlugin = FlutterLocalNotificationsPlugin();

    flutterNotificationPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  send(String title, String text) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Notification Channel ID',
      'Channel Name',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterNotificationPlugin.show(
        0,
        title,
        text,
        platformChannelSpecifics,
        payload: 'No Sound'
    );
  }

  onSelectNotification(dynamic payload) async {
    print("HELLO NOTIFICATION $payload");
  }
}
