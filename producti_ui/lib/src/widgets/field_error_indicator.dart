import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';

class FieldErrorIndicator extends StatefulWidget {
  final String message;

  const FieldErrorIndicator({Key? key, required this.message})
      : super(key: key);

  @override
  _FieldErrorIndicatorState createState() => _FieldErrorIndicatorState();
}

class _FieldErrorIndicatorState extends State<FieldErrorIndicator> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.caption!.copyWith(
      color: theme.backgroundColor,
    );

    final size = _textSize(widget.message, style);

    return Container(
      width: size.width + 8,
      height: size.height + 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular((size.height) + 8 / 2),
        color: kRed,
      ),
      child: Center(
        child: Text(
          widget.message,
          style: style,
        ),
      ),
    );
  }

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: 0,
        maxWidth: double.infinity,
      );
    return textPainter.size;
  }
}
