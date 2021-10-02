import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:producti/domain/table/local_table_repository.dart';
import 'package:producti/domain/table/remote_table_repository.dart';

part 'table_event.dart';
part 'table_state.dart';

@lazySingleton
class TableBloc extends Bloc<TableEvent, TableState> {
  final RemoteTableRepository _remoteTableRepository;
  final LocalTableRepository _localTableRepository;

  TableBloc(this._remoteTableRepository, this._localTableRepository)
      : super(TableInitial());

  @override
  Stream<TableState> mapEventToState(TableEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
