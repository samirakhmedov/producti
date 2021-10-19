part of 'anonymous_table_bloc.dart';

abstract class AnonymousTableEvent extends Equatable {
  const AnonymousTableEvent();

  @override
  List<Object> get props => [];
}

class AnonymousTableLoad extends AnonymousTableEvent {}

class AnonymousTableCreate extends AnonymousTableEvent {
  final String name;

  AnonymousTableCreate(this.name);

  @override
  List<Object> get props => [name];
}

class AnonymousTableGroupCreate extends AnonymousTableEvent {
  final String name;
  final TableLink? path;
  final int tableIndex;

  AnonymousTableGroupCreate({
    required this.name,
    this.path,
    required this.tableIndex,
  });

  @override
  List<Object> get props => [name, path ?? 0, tableIndex];
}

class AnonymousTableSave extends AnonymousTableEvent {}
