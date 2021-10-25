part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];

  Map<String, dynamic> toJson();

  factory AuthState.fromJson(Map<String, dynamic> json) {
    final state = json['state'] as String;

    switch (state) {
      case 'initial':
        return AuthInitial();
      case 'logged_in':
        return AuthLoggedIn(
          User.fromJson(
            json['user'] as Map<String, dynamic>,
          ),
        );
      case 'logged_out':
        return AuthLoggedOut();
      case 'anonymous':
        return AuthAnonymousState();
    }

    return AuthInitial();
  }
}

class AuthInitial extends AuthState {
  @override
  Map<String, dynamic> toJson() => {
        'state': 'initial',
      };
}

class AuthErrorState extends AuthState {
  final Failure failure;

  const AuthErrorState(this.failure);

  @override
  List<Object> get props => [failure];

  @override
  Map<String, dynamic> toJson() => {
        'state': 'initial',
      };
}

class AuthLoadingState extends AuthState {
  @override
  Map<String, dynamic> toJson() => {
        'state': 'initial',
      };
}

class AuthLoggedIn extends AuthState {
  final User user;

  const AuthLoggedIn(this.user);

  @override
  Map<String, dynamic> toJson() => {
        'state': 'logged_in',
        'user': user.toJson(),
      };

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'AuthLoggedIn(${user.id})';
}

class AuthLoggedOut extends AuthState {
  @override
  Map<String, dynamic> toJson() => {
        'state': 'logged_out',
      };
}

class AuthAnonymousState extends AuthState {
  @override
  Map<String, dynamic> toJson() => {
        'state': 'anonymous',
      };
}
