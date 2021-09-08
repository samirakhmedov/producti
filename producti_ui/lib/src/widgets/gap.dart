import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double size;

  const Gap({Key? key, this.size = 10}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
    );
  }
}
