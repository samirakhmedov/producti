part of 'note_validation_cubit.dart';

class NoteValidationState extends Equatable {
  final String title;
  final String description;
  final List<Link> links;
  final bool showErrors;

  const NoteValidationState({
    this.title = '',
    this.description = '',
    this.links = const [],
    this.showErrors = false,
  });

  ErrorCode? get error {
    if (title.isEmpty && description.isEmpty) return ErrorCode.voidValue;

    if (links.any((element) => element.currentValue.isEmpty)) {
      return ErrorCode.voidLinkValue;
    }

    if (links.any((element) => element.validatedValue.isLeft())) {
      return ErrorCode.invalidLink;
    }

    return null;
  }

  @override
  List<Object> get props => [title, description, links, showErrors];

  NoteValidationState copyWith({
    String? title,
    String? description,
    List<Link>? links,
    bool? showErrors,
  }) {
    return NoteValidationState(
      title: title ?? this.title,
      description: description ?? this.description,
      links: links ?? this.links,
      showErrors: showErrors ?? this.showErrors,
    );
  }

  NoteTableCell toNoteCell() {
    return NoteTableCell(
      description: description,
      links: links.map((e) => e.getOrCrash()).toList(),
      title: title,
    );
  }
}
