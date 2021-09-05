import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:producti/generated/l10n.dart';

final routes = {
  '/': (BuildContext context) => Scaffold(
        body: SafeArea(
          child: SizedBox(
            child: Center(
              child: Column(
                children: [
                  Text(
                    S.of(context).test,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.backpack,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
};
