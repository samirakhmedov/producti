import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:producti/application/core/cubit/connection_cubit.dart';
import 'package:producti/data/core/error/failure.dart';
import 'package:producti/domain/table/local_table_repository.dart';
import 'package:producti/domain/table/remote_table_repository.dart';
import 'package:producti/domain/table/table.dart';

part 'table_event.dart';
part 'table_state.dart';

@lazySingleton
class TableBloc extends Bloc<TableEvent, TableState> {
  final RemoteTableRepository _remoteTableRepository;
  final LocalTableRepository _localTableRepository;
  final ConnectionCubit _connection;

  TableBloc(
    this._remoteTableRepository,
    this._localTableRepository,
    this._connection,
  ) : super(TableInitial()) {
    on<TableEvent>((event, emit) async {
      if (event is TableLoad) {
        if (_connection.connected) {
          emit(TableLoadingState());

          final result = await _remoteTableRepository.loadData(event.uid);

          emit(
            await result.fold(
              (failure) async {
                final tables = _localTableRepository.loadData();

                return TableLoadedState(tables, failure: failure);
              },
              (tables) => TableLoadedState(tables),
            ),
          );
        } else {
          final tables = _localTableRepository.loadData();

          emit(TableLoadedState(tables));
        }
      }
    });
  }
}
