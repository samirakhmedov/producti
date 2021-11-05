import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:producti_ui/producti_ui.dart';

class TimeWidget extends StatelessWidget {
  final DateTime time;

  const TimeWidget({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);

    final textTheme = theme.textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (time.isBefore(DateTime.now())) ...[
          const Icon(
            Icons.check,
            color: kGreen,
          ),
          const Gap(),
        ],
        const Icon(Icons.access_time),
        const Gap(),
        Text(
          DateFormat('dd.MM.yyyy, kk:mm').format(time),
          style: textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.primaryColor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
