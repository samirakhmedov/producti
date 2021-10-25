import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

/// TODO: Implement after s h o w c a s e
class TableShowcasePage extends StatelessWidget {
  const TableShowcasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
              ),
            ),
          );
        },
      ),
    );
  }
}
