part of 'group_create_cubit.dart';

class GroupCreateState extends Equatable {
  final List<GroupTableCell> cells;

  final String groupName;

  final bool showErrors;

  const GroupCreateState({
    required this.cells,
    this.groupName = '',
    this.showErrors = false,
  });

  @override
  List<Object> get props => [cells, groupName, showErrors];

  ErrorCode? get error {
    if (groupName.isEmpty) return ErrorCode.voidValue;

    if (groupName.length > 60) return ErrorCode.tooBigValue;

    if (cells.any((element) => element.title == groupName)) {
      return ErrorCode.groupAlreadyExists;
    }
  }

  GroupCreateState copyWith({
    List<GroupTableCell>? cells,
    String? groupName,
    bool? showErrors,
  }) {
    return GroupCreateState(
      cells: cells ?? this.cells,
      groupName: groupName ?? this.groupName,
      showErrors: showErrors ?? this.showErrors,
    );
  }
}
