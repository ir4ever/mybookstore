import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mybookstore/features/auth/domain/entities/auth_entity.dart';
import 'package:mybookstore/features/auth/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthState.unauthenticated()) {
    on<AuthInitEvent>(onInitRequest);
    on<AuthSignInEvent>(_onSignInPressed);
    on<AuthSignOutEvent>(_onSignOutPressed);
  }

  final AuthRepository _authRepository;

  void onInitRequest(AuthInitEvent event, Emitter<AuthState> emit) => emit(const AuthState.unauthenticated());

  Future<void> _onSignInPressed(AuthSignInEvent event, Emitter<AuthState> emit) async {
    return emit.onEach(
      _authRepository.status,
      onData: (status) async {
        switch (status) {
          case AuthStatus.unauthenticated:
            return emit(const AuthState.unauthenticated());
          case AuthStatus.authenticated:
            final auth = _authRepository.getAuthEntity();
            return emit(
              auth != null ? AuthState.authenticated(auth) : const AuthState.unauthenticated(),
            );
        }
      },
      onError: addError,
    );
  }

  void _onSignOutPressed(
    AuthSignOutEvent event,
    Emitter<AuthState> emit,
  ) {
    _authRepository.signOut();
  }
}
