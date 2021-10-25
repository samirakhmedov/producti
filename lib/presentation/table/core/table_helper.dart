import 'package:flutter/material.dart';
import 'package:producti/presentation/core/constants/routes.dart';
import 'package:producti/presentation/table/pages/tables_page.dart';

class TableHelper {
  static void moveToTable(BuildContext context, int tableIndex) {
    final navigator = Navigator.of(context);

    navigator.popUntil((route) => false);

    navigator.push(
      MaterialPageRoute(
        builder: (context) => TablesPage(
          tableIndex: tableIndex,
        ),
        settings: const RouteSettings(
          name: AppRoutes.tables,
        ),
      ),
    );
  }
}
