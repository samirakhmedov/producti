import 'package:flutter/material.dart';
import 'package:producti_ui/producti_ui.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        width: double.maxFinite,
        height: 2,
        color: kGray,
      ),
    );
  }
}
