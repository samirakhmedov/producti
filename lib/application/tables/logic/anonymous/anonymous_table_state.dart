part of 'anonymous_table_bloc.dart';

abstract class AnonymousTableState {
  const AnonymousTableState();

  // @override
  // List<Object> get props => [];
}

class AnonymousTableInitial extends AnonymousTableState {}

class AnonymousTableLoaded extends AnonymousTableState {
  final List<Table> tables;

  AnonymousTableLoaded(this.tables);

  // @override
  // List<Object> get props => [tables];

  AnonymousTableLoaded copyWith({
    List<Table>? tables,
  }) {
    return AnonymousTableLoaded(
      tables ?? this.tables,
    );
  }
}
