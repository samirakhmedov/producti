part of 'table_cell.dart';

@HiveType(typeId: HiveConstants.checkListTableCellId)
@immutable
class CheckListTableCell extends TableCell {
  @HiveField(1)
  final List<CheckTileTableCell> checkList;

  @HiveField(0)
  final String title;

  CheckListTableCell({
    this.checkList = const [],
    this.title = '',
  }) : super(title);

  factory CheckListTableCell.fromJson(Map<String, dynamic> json) {
    return CheckListTableCell(
      title: json['title'] as String,
      checkList: (json as List)
          .cast<Map<String, dynamic>>()
          .map<CheckTileTableCell>((e) => CheckTileTableCell.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [checkList, title];

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'checkList': checkList
          .map(
            (e) => e.toJson(),
          )
          .toList(),
    };
  }

  CheckListTableCell copyWith({
    List<CheckTileTableCell>? checkList,
    String? title,
  }) {
    return CheckListTableCell(
      checkList: checkList ?? this.checkList,
      title: title ?? this.title,
    );
  }
}

@HiveType(typeId: HiveConstants.checkTileTableCellId)
@immutable
class CheckTileTableCell extends TableCell {
  @HiveField(1)
  final bool value;

  CheckTileTableCell({
    this.value = false,
    @HiveField(0) String title = '',
  }) : super(title);

  factory CheckTileTableCell.fromJson(Map<String, dynamic> json) {
    return CheckTileTableCell(
      title: json['title'] as String,
      value: json['value'] as bool,
    );
  }

  @override
  List<Object?> get props => [title, value];

  @override
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'title': title,
    };
  }

  CheckTileTableCell copyWith({
    bool? value,
    String? title,
  }) {
    return CheckTileTableCell(
      value: value ?? this.value,
      title: title ?? this.title,
    );
  }
}
