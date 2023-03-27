import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final notificationPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('xampp');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await notificationPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails("channelId", "channelName",
            importance: Importance.max));
  }

  Future showNotification(
      {int id = 0, String? title, String? payload, String? body}) async {
    return notificationPlugin.show(
        id, title, body, await notificationDetails());
  }
}
