part of 'table_bloc.dart';

abstract class TableState extends Equatable {
  const TableState();

  @override
  List<Object> get props => [];
}

class TableInitial extends TableState {}

class TableLoadingState extends TableState {}

class TableFailureState extends TableState {
  final Failure failure;

  TableFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}

class TableLoadedState extends TableState {
  final List<Table> tables;
  final Failure? failure;

  TableLoadedState(this.tables, {this.failure});

  @override
  List<Object> get props => [tables, failure ?? 0];
}
