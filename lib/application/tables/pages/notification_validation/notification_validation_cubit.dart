import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/values/link.dart';

part 'notification_validation_state.dart';

class NotificationValidationCubit extends Cubit<NotificationValidationState> {
  NotificationValidationCubit(NotificationTableCell? initialData)
      : super(
          const NotificationValidationState(),
        ) {
    emit(
      state.copyWith(
        description: initialData?.description,
        links: initialData?.links.map((e) => Link(e)).toList(),
        title: initialData?.title,
        dateTime: initialData?.time,
      ),
    );
  }

  void mutate({
    String? title,
    String? description,
    List<Link>? links,
    DateTime? dateTime,
    bool? showErrors,
  }) {
    emit(
      state.copyWith(
        title: title,
        description: description,
        links: links,
        showErrors: showErrors,
        dateTime: dateTime,
      ),
    );
  }
}
