part of 'table_bloc.dart';

abstract class TableState extends Equatable {
  const TableState();
  
  @override
  List<Object> get props => [];
}

class TableInitial extends TableState {}
