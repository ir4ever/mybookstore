part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthInitEvent extends AuthEvent {}

final class AuthSignInEvent extends AuthEvent {}

final class AuthSignOutEvent extends AuthEvent {}
