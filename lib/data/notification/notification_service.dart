import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../app/routes.dart';
import '../../main.dart';

const _androidDetails = AndroidNotificationDetails(
  'pasia_channel_id',
  'Reminder noticaitions',
  channelDescription: 'Show notifications whenever possible to add expense',
  priority: Priority.low,
  importance: Importance.high,
);
const _notificationDetails = NotificationDetails(
  android: _androidDetails,
);

class NotificationService {
  final notification = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('app_icon');
    const iosSettings = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    await notification.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
  }

  Future selectNotification(String? payload) async {
    await mainNavigator.currentState!.pushNamed(addExpenseScreen);
  }

  Future<void> show() async {
    await notification.show(
      0,
      'Add expense',
      'Don\'t forgot to add your daily expenses',
      _notificationDetails,
      payload: 'Notification Payload',
    );
  }

  Future<void> sechuldeNotification() async {
    await notification.zonedSchedule(
      0,
      'Add expense',
      'Don\'t forgot to add your daily expenses',
      _nextInstanceOfEightPM(const Time(20)),
      _notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfEightPM(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }
}
