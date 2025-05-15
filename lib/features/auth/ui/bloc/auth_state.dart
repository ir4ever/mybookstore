part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._({this.status = AuthStatus.unauthenticated, this.authEntity});

  const AuthState.authenticated(AuthEntity? authEntity)
      : this._(status: AuthStatus.authenticated, authEntity: authEntity);

  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final AuthEntity? authEntity;

  @override
  List<Object?> get props => [status, authEntity];
}
