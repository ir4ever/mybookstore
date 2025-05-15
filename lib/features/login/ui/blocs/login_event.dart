part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

final class SignInButtonPressed extends LoginEvent {
  final String user;
  final String password;
  const SignInButtonPressed(this.user, this.password);
  @override
  List<Object> get props => [];
}

final class SignUpButtonPressed extends LoginEvent {
  final AdminStoreEntity store;
  const SignUpButtonPressed(this.store);

  @override
  List<Object> get props => [];
}
