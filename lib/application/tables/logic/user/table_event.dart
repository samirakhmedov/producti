part of 'table_bloc.dart';

abstract class TableEvent extends Equatable {
  const TableEvent();

  @override
  List<Object> get props => [];
}

class TableLoad extends TableEvent {
  final String uid;

  TableLoad(this.uid);

  @override
  List<Object> get props => [uid];
}
