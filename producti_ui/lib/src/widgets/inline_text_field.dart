import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';

class InlineTextField extends StatelessWidget {
  final void Function(String value)? onSubmit;
  final String? initialValue;
  final void Function(String value)? onChange;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextStyle? textStyle;
  final Widget? suffixWidget;
  final String? hintText;
  final TextStyle? hintStyle;

  const InlineTextField({
    Key? key,
    this.onSubmit,
    this.initialValue,
    this.onChange,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.suffixWidget,
    this.hintText,
    this.hintStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper.getTheme(context);

    return TextFormField(
      focusNode: focusNode,
      autofocus: autofocus,
      initialValue: initialValue,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      style: textStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: theme.backgroundColor,
        contentPadding: EdgeInsets.zero,
        suffix: suffixWidget,
        isDense: true,
        hintText: hintText,
        hintStyle: hintStyle,
      ),
      cursorColor: theme.primaryColor,
    );
  }
}
