import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/values/check_tile.dart';

part 'check_list_validation_cell_state.dart';

class CheckListValidationCubit extends Cubit<CheckListValidationState> {
  final CheckListTableCell? initialData;

  CheckListValidationCubit(this.initialData)
      : super(
          const CheckListValidationState(),
        ) {
    emit(
      state.copyWith(
        tiles: initialData?.checkList
            .map(
              (e) => CheckTile(e.title, e.value),
            )
            .toList(),
        title: initialData?.title,
      ),
    );
  }

  void mutate({
    String? title,
    bool? showErrors,
    List<CheckTile>? tiles,
  }) {
    emit(
      state.copyWith(
        showErrors: showErrors ?? state.showErrors,
        tiles: tiles ?? state.tiles,
        title: title ?? state.title,
      ),
    );
  }
}
