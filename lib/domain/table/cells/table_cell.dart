import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:producti/domain/core/hive_constants.dart';
import 'package:producti/domain/table/values/link.dart';

part 'group_table_cell.dart';
part 'note_table_cell.dart';
part 'notification_table_cell.dart';

part 'table_cell.g.dart';

abstract class TableCell extends Equatable {
  final String title;

  TableCell(this.title);

  Map<String, dynamic> toJson();

  factory TableCell.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('children')) return GroupTableCell.fromJson(json);
    if (json.containsKey('date')) return NotificationTableCell.fromJson(json);

    return NoteTableCell.fromJson(json);
  }
}
