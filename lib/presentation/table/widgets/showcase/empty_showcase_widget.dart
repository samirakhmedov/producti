import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class EmptyShowcaseWidget extends StatelessWidget {
  final GlobalKey globalKey;
  final Widget child;

  const EmptyShowcaseWidget({
    Key? key,
    required this.globalKey,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Showcase.withWidget(
      key: globalKey,
      container: const SizedBox(),
      height: 0,
      width: 0,
      child: child,
    );
  }
}
