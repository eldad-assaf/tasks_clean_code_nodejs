part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  final UserEntity? userEntity;
  final DioException? error;

  const LoginState({this.userEntity, this.error});

  @override
  List<Object> get props => [userEntity ?? '', error ?? ''];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginInProgress extends LoginState {
  const LoginInProgress();
}

class LoggedinSuccessfully extends LoginState {
  const LoggedinSuccessfully(UserEntity userEntity)
      : super(userEntity: userEntity);
}

class LoginError extends LoginState {
  const LoginError(DioException error) : super(error: error);
}
