import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;

  const PasswordTextField({
    Key? key,
    this.controller,
    this.hintText,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextInputWidget(
      controller: widget.controller,
      obscureText: _obscureText,
      hintText: widget.hintText,
      prefixIcon: Icons.vpn_key,
      suffixWidget: InkWell(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: Icon(
          _obscureText ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
          color: theme.primaryColor,
          size: 20,
        ),
      ),
    );
  }
}
