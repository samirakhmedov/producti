import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:producti/domain/table/local_table_repository.dart';
import 'package:producti/domain/table/table.dart';

part 'anonymous_table_event.dart';
part 'anonymous_table_state.dart';

@lazySingleton
class AnonymousTableBloc
    extends Bloc<AnonymousTableEvent, AnonymousTableState> {
  final LocalTableRepository _localTableRepository;

  AnonymousTableBloc(this._localTableRepository)
      : super(AnonymousTableInitial()) {
    add(AnonymousTableLoad());
  }

  @override
  Stream<AnonymousTableState> mapEventToState(
      AnonymousTableEvent event) async* {
    if (event is AnonymousTableLoad) {
      final result = await _localTableRepository.loadData();

      yield AnonymousTableLoaded(result);
    }
  }
}