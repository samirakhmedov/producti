import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/domain/table/cells/table_cell.dart';
import 'package:producti/domain/table/values/link.dart';

part 'note_validation_state.dart';

class NoteValidationCubit extends Cubit<NoteValidationState> {
  NoteValidationCubit(NoteTableCell? initialData)
      : super(
          const NoteValidationState(),
        ) {
    emit(
      state.copyWith(
        description: initialData?.description,
        links: initialData?.links.map((e) => Link(e)).toList(),
        title: initialData?.title,
      ),
    );
  }

  void mutate({
    String? title,
    String? description,
    List<Link>? links,
    bool? showErrors,
  }) =>
      emit(
        state.copyWith(
          title: title,
          description: description,
          links: links,
          showErrors: showErrors,
        ),
      );
}
