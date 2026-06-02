import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_signup_app/core/services/session_service.dart';
import 'package:flutter_login_signup_app/data/database/user_table.dart';
import 'package:flutter_login_signup_app/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  final SessionService sessionService;

  AuthBloc({required this.repository, required this.sessionService})
    : super(const AuthInitial()) {
    on<LoginRequested>(_onLogin);
    on<RegisterUserRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);
    on<GetUserRequested>(_onGetUser);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await repository.login(
      email: event.email,
      password: event.password,
    );

    await result.fold(
      (error) async {
        emit(AuthFailure(error));
      },
      (user) async {
        await sessionService.saveUser(user.mobile);

        emit(AuthSuccess(user));
      },
    );
  }

  Future<void> _onRegister(
    RegisterUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await repository.registerUser(event.user);

    result.fold(
      (error) => emit(AuthFailure(error)),
      (_) => emit(const AuthRegisterSuccess()),
    );
  }

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    await sessionService.logout();

    emit(const AuthLoggedOut());
  }

  Future<void> _onGetUser(
    GetUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await repository.getUserByMobile(event.mobile);

    result.fold(
      (error) => emit(AuthFailure(error)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
