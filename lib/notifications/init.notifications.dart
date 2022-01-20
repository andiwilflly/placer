import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
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

  send() {
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

    print('de?');
    flutterNotificationPlugin.show(0, 'New Alert',
        'How to show Local Notification', platformChannelSpecifics,
        payload: 'Default Sound');
  }

  onSelectNotification(dynamic payload) async {
    print("HELLO NOTIFICATION $payload");
  }
}
