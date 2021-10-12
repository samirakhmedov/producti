import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OptionText extends StatelessWidget {
  final String start;
  final String end;
  final void Function() onTap;
  final TextAlign? textAlign;

  const OptionText({
    Key? key,
    required this.start,
    required this.end,
    required this.onTap,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    return RichText(
      textAlign: textAlign ?? TextAlign.center,
      text: TextSpan(
        text: start,
        style: textTheme.subtitle1,
        children: [
          TextSpan(
            text: end,
            style: textTheme.subtitle1!.copyWith(
              color: theme.primaryColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
