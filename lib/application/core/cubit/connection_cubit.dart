import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'connection_state.dart';

@injectable
class ConnectionCubit extends Cubit<ConnectionCubitState> {
  final Connectivity _connectivity;

  ConnectionCubit(this._connectivity) : super(ConnectionCubitState(true)) {
    _connectivity.onConnectivityChanged.listen(_connectionStateChange);
  }

  void _connectionStateChange(ConnectivityResult event) => emit(
        state.copyWith(
          hasConnection: event != ConnectivityResult.none,
        ),
      );
}
