part of 'notification_validation_cubit.dart';

class NotificationValidationState extends Equatable {
  final String title;
  final String description;
  final List<Link> links;
  final DateTime? dateTime;
  final bool showErrors;

  const NotificationValidationState({
    this.title = '',
    this.description = '',
    this.links = const [],
    this.dateTime,
    this.showErrors = false,
  });

  @override
  List<Object> get props => [
        title,
        description,
        links.map((e) => e.currentValue).toList(),
        dateTime?.millisecondsSinceEpoch ?? 0,
        showErrors,
      ];

  NotificationValidationState copyWith({
    String? title,
    String? description,
    List<Link>? links,
    DateTime? dateTime,
    bool? showErrors,
  }) {
    return NotificationValidationState(
      title: title ?? this.title,
      description: description ?? this.description,
      links: links ?? this.links,
      dateTime: dateTime ?? this.dateTime,
      showErrors: showErrors ?? this.showErrors,
    );
  }

  ErrorCode? get error {
    if (title.isEmpty && description.isEmpty) return ErrorCode.voidValue;

    if (dateTime == null) return ErrorCode.voidValue;

    if (dateTime?.isBefore(DateTime.now()) ?? false) {
      return ErrorCode.notificationInPast;
    }

    if (links.any((element) => element.currentValue.isEmpty)) {
      return ErrorCode.voidLinkValue;
    }

    if (links.any((element) => element.validatedValue.isLeft())) {
      return ErrorCode.invalidLink;
    }
  }

  NotificationTableCell toNoteCell() {
    return NotificationTableCell(
      description: description,
      links: links.map((e) => e.getOrCrash()).toList(),
      title: title,
      time: dateTime!,
    );
  }
}
