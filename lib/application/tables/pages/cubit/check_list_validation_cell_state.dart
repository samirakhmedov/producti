part of 'check_list_validation_cell_cubit.dart';

class CheckListValidationState extends Equatable {
  final String title;
  final bool showErrors;
  final List<CheckTile> tiles;

  const CheckListValidationState({
    this.showErrors = false,
    this.title = '',
    this.tiles = const [],
  });

  @override
  List<Object> get props => [
        title,
        tiles,
        showErrors,
      ];

  ErrorCode? get error {
    if (title.isEmpty) return ErrorCode.voidValue;

    if (tiles.isEmpty) return ErrorCode.noTiles;

    if (tiles.any((element) => element.validatedValue.isLeft())) {
      return ErrorCode.voidLinkValue;
    }

    return null;
  }

  CheckListTableCell toCell() => CheckListTableCell(
        title: title,
        checkList: tiles
            .map(
              (e) => CheckTileTableCell(
                title: e.getOrCrash(),
                value: e.initialValue ?? false,
              ),
            )
            .toList(),
      );

  CheckListValidationState copyWith({
    String? title,
    bool? showErrors,
    List<CheckTile>? tiles,
  }) {
    return CheckListValidationState(
      title: title ?? this.title,
      showErrors: showErrors ?? this.showErrors,
      tiles: tiles ?? this.tiles,
    );
  }
}
