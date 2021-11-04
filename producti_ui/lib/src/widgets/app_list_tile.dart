import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';

class AppListTile extends StatelessWidget {
  final String title;

  final void Function()? onTap;

  const AppListTile({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = ThemeHelper.getTextTheme(context);

    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: textTheme.bodyText2,
      ),
      contentPadding: EdgeInsets.zero,
      trailing: Icon(
        Icons.chevron_right,
        size: 10,
        color: ThemeHelper.isDarkMode(context) ? kGray : kLightGray,
      ),
    );
  }
}
