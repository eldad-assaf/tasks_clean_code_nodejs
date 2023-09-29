part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginUserEvent extends LoginEvent {
  final LoginRequest? loginRequest;

  const LoginUserEvent(this.loginRequest);

  @override
  List<Object?> get props => [loginRequest];
}

class LogoutUserEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
