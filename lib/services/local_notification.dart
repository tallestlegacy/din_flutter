import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/ic_stat_');

showNotification() async {
/*
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

*/
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    // iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'din_notification',
    'Time for ...',
    description: 'DateTime of Asr',
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin.show(
    1,
    'Time for AdhanName',
    'DateTime >> __',
    NotificationDetails(
      android: AndroidNotificationDetails(channel.id, channel.name,
          channelDescription: channel.description),
    ),
  );
}

Future<void> showScheduledNotification({
  required int id,
  required String title,
  required String body,
  required int seconds,
}) async {}
