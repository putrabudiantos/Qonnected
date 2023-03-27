import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Noti {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'you_can_name_it_whatever1',
      'channel_name',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );

    var not = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails());
    await fln.show(0, title, body, not);
  }
}

// class LocalNotificationService {
//   LocalNotificationService();

//   final _localNotificationService = FlutterLocalNotificationsPlugin();

//   Future<void> initialize() async {
//     const AndroidInitializationSettings androidInitialSetting =
//         AndroidInitializationSettings('@drawable/ic_laucher');

//     InitializationSettings settings = InitializationSettings(
//         iOS: DarwinInitializationSettings(
//             requestAlertPermission: true,
//             requestBadgePermission: true,
//             requestSoundPermission: true,
//             onDidReceiveLocalNotification: onDidReceiveLocalNotification),
//         android: androidInitialSetting);

//     await _localNotificationService.initialize(settings,
//         onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
//   }

//   Future<NotificationDetails> _notificationDetails() async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('channel_id', 'channel_name',
//             channelDescription: 'Description',
//             importance: Importance.max,
//             priority: Priority.max,
//             playSound: true);
//     const NotificationDetails notifDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: DarwinNotificationDetails());
//     return notifDetails;
//   }

//   Future<void> showNotification(
//       {required int id, required String title, required String body}) async {
//     final details = await _notificationDetails();
//     await _localNotificationService.show(id, title, body, details);
//   }

//   void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) {
//     print(id);
//   }

//   void onDidReceiveNotificationResponse(NotificationResponse details) {
//     print(details);
//   }
// }
