import 'package:dartz/dartz.dart';
import 'package:producti/data/core/error/failure.dart';
import 'package:producti/domain/notifications/notification.dart';

abstract class NotificationRepositry {
  Future<Either<Failure, void>> setup();

  Future<void> setNotification(Notification notification);
}
