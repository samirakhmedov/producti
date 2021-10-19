import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/domain/table/cells/table_cell.dart';

part 'group_create_state.dart';

class GroupCreateCubit extends Cubit<GroupCreateState> {
  GroupCreateCubit(List<GroupTableCell> cells)
      : super(
          GroupCreateState(
            cells: cells,
          ),
        );

  void mutate({
    String? groupName,
    bool? showErrors,
  }) =>
      emit(
        state.copyWith(
          showErrors: showErrors,
          groupName: groupName,
        ),
      );
}
