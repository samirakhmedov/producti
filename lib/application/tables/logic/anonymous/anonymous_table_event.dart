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
