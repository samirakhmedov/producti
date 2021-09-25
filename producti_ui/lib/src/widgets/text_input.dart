import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';
import 'package:producti_ui/src/constants.dart';

class TextInputWidget extends StatefulWidget {
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final String? hintText;
  final bool obscureText;
  final Widget? suffixWidget;

  const TextInputWidget({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.hintText,
    this.obscureText = false,
    this.suffixWidget,
  }) : super(key: key);

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    final focus = FocusNode();

    keyboardVisibility.onChange.listen((v) {
      if (focus.hasFocus && !v) {
        focus.unfocus();
      }
    });

    return TextField(
      focusNode: focus,
      controller: widget.controller,
      cursorColor: theme.primaryColor,
      obscureText: widget.obscureText,
      style: textTheme.bodyText2!.copyWith(
        color: theme.backgroundColor,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: EdgeInsets.zero,
        hintStyle: textTheme.caption!.copyWith(
          color: kDarkerGray,
        ),
        fillColor: kGray,
        filled: true,
        prefixIcon: Icon(
          widget.prefixIcon,
          color: theme.primaryColor,
          size: 20,
        ),
        suffixIcon: widget.suffixWidget,
      ),
    );
  }
}
