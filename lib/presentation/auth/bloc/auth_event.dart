part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class RegisterUserRequested extends AuthEvent {
  final UserEntity user;

  const RegisterUserRequested(this.user);

  @override
  List<Object?> get props => [user];
}

final class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

final class GetUserRequested extends AuthEvent {
  final String mobile;

  const GetUserRequested(this.mobile);

  @override
  List<Object?> get props => [mobile];
}

final class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}
