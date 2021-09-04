import 'package:flutter/cupertino.dart';
import 'package:producti/generated/l10n.dart';

final routes = {
  '/': (BuildContext context) => SizedBox(
        child: Center(
          child: Text(S.of(context).test),
        ),
      ),
};
