import 'package:equatable/equatable.dart';

abstract class TableCell extends Equatable {
  final String title;

  TableCell(this.title);
}
