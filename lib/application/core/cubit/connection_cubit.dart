import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'connection_state.dart';

@lazySingleton
class ConnectionCubit extends Cubit<ConnectionCubitState> {
  final Connectivity _connectivity;

  ConnectionCubit(this._connectivity)
      : super(const ConnectionCubitState(ConnectionStatus.unknown)) {
    _connectivity.checkConnectivity().then(
          (value) => emit(
            state.copyWith(
              connectionStatus: value != ConnectivityResult.none
                  ? ConnectionStatus.connected
                  : ConnectionStatus.disconnected,
            ),
          ),
        );

    _connectivity.onConnectivityChanged.listen(_connectionStateChange);
  }

  void _connectionStateChange(ConnectivityResult event) => emit(
        state.copyWith(
          connectionStatus: event != ConnectivityResult.none
              ? ConnectionStatus.connected
              : ConnectionStatus.disconnected,
          showStatus: ConnectionShowStatus.show,
        ),
      );

  bool get connected => state.connectionStatus == ConnectionStatus.connected;
}
