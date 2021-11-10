import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final void Function()? onTap;

  const ClickableText({
    Key? key,
    required this.text,
    this.onTap,
    this.color,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: textStyle?.copyWith(
              color: color ?? theme.primaryColor,
            ) ??
            textTheme.bodyText2!.copyWith(
              color: color ?? theme.primaryColor,
            ),
      ),
    );
  }
}
