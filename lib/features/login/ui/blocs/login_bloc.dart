import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mybookstore/features/auth/domain/entities/auth_entity.dart';
import 'package:mybookstore/features/auth/domain/repositories/auth_repository.dart';
import 'package:mybookstore/features/store/domain/entities/admin_store_entity.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginInitial()) {
    on<SignInButtonPressed>(_onSignIn);
    on<SignUpButtonPressed>(_onSignUp);
  }

  final AuthRepository _authRepository;

  Future<void> _onSignIn(SignInButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      final auth = await _authRepository.signIn(user: event.user, password: event.password);
      if (auth != null) return emit(LoginSuccess(auth));
      return emit(LoginError('Não foi possível obter os dados do usuário'));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> _onSignUp(SignUpButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      final auth = await _authRepository.signUp(event.store);
      if (auth != null) return emit(LoginSuccess(auth));
      return emit(LoginError('Não foi possível criar sua loja nesse momento'));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
