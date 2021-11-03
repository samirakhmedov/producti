import 'package:dartz/dartz.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:producti/data/core/error/failure.dart';
import 'package:producti/domain/notifications/notification.dart';

abstract class NotificationRepository {
  Future<Either<Failure, void>> setup(
    void Function(String?) onSelectNotification,
  );

  Future<void> setNotification(
    Notification notification, {
    required int tableIndex,
  });

  Future<void> deleteNotifications(List<int> ids);

  Future<NotificationAppLaunchDetails?> getAppLaunchDetails();
}
