part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginUser extends LoginEvent {
  final LoginRequestData? loginRequestData;

  const LoginUser(this.loginRequestData);
  
  @override
  List<Object?> get props => [loginRequestData];
}
