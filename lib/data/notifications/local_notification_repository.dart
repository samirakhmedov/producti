import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/data/core/error/failure.dart';
import 'package:producti/domain/notifications/notification.dart';
import 'package:producti/domain/notifications/notification_repository.dart';
import 'package:timezone/timezone.dart';

@lazySingleton
class LocalNotificationRepository extends NotificationRepositry {
  static const AndroidInitializationSettings _initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/ic_notification_icon');
  static const IOSInitializationSettings _initializationSettingsIOS =
      IOSInitializationSettings();
  static const InitializationSettings _initializationSettings =
      InitializationSettings(
    android: _initializationSettingsAndroid,
    iOS: _initializationSettingsIOS,
  );

  static const _notificationsDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'com.ludev.producti.notifications',
      'main_notifications',
      importance: Importance.high,
    ),
    iOS: IOSNotificationDetails(),
  );

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  final IOSFlutterLocalNotificationsPlugin _iosFlutterLocalNotificationsPlugin;

  LocalNotificationRepository(
    this._flutterLocalNotificationsPlugin,
    this._iosFlutterLocalNotificationsPlugin,
  );

  @override
  Future<Either<Failure, void>> setup() async {
    final initializationResult =
        await _flutterLocalNotificationsPlugin.initialize(
      _initializationSettings,
    );

    if (!initializationResult!) {
      if (Platform.isIOS) {
        final permissionRequestResult =
            await _iosFlutterLocalNotificationsPlugin.requestPermissions(
          sound: true,
          alert: true,
          badge: true,
        );

        if (permissionRequestResult!) return setup();
      }

      return left(
        const NotificationFailure(
          ErrorCode.notificationsInitializationFailure,
        ),
      );
    }

    return right(null);
  }

  @override
  Future<void> setNotification(Notification notification) async {
    final time = notification.time;

    final timeZoneName = time.timeZoneName;

    return _flutterLocalNotificationsPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      TZDateTime(
        Location(
          timeZoneName,
          [],
          [],
          [],
        ),
        time.year,
        time.month,
        time.day,
        time.day,
        time.hour,
        time.minute,
      ),
      _notificationsDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      androidAllowWhileIdle: true,
    );
  }
}
