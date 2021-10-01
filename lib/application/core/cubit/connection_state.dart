part of 'connection_cubit.dart';

class ConnectionCubitState extends Equatable {
  final bool hasConnection;

  const ConnectionCubitState(this.hasConnection);

  @override
  List<Object> get props => [hasConnection];

  ConnectionCubitState copyWith({
    bool? hasConnection,
  }) {
    return ConnectionCubitState(
      hasConnection ?? this.hasConnection,
    );
  }
}
