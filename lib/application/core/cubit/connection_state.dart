part of 'connection_cubit.dart';

enum ConnectionStatus { unknown, connected, disconnected }

enum ConnectionShowStatus { show, hide }

class ConnectionCubitState extends Equatable {
  final ConnectionStatus connectionStatus;
  final ConnectionShowStatus showStatus;

  const ConnectionCubitState(this.connectionStatus,
      {this.showStatus = ConnectionShowStatus.hide});

  @override
  List<Object> get props => [connectionStatus];

  ConnectionCubitState copyWith({
    ConnectionStatus? connectionStatus,
    ConnectionShowStatus? showStatus,
  }) {
    return ConnectionCubitState(
      connectionStatus ?? this.connectionStatus,
      showStatus: showStatus ?? this.showStatus,
    );
  }
}
