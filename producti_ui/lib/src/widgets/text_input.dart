import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:producti_ui/producti_ui.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final String? hintText;

  const TextInputWidget({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    final focus = FocusNode();

    KeyboardVisibilityController().onChange.listen((visible) {
      if (!visible && focus.hasFocus) {
        focus.unfocus();
      }
    });

    return SizedBox(
      height: 40,
      child: TextField(
        focusNode: focus,
        controller: controller,
        cursorColor: theme.primaryColor,
        style: textTheme.bodyText2!.copyWith(
          color: theme.backgroundColor,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.zero,
          hintStyle: textTheme.bodyText2!.copyWith(
            color: kDarkerGray,
          ),
          fillColor: kGray,
          filled: true,
          prefixIcon: Icon(
            prefixIcon,
            color: theme.primaryColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
