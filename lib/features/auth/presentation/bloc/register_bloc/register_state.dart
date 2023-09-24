part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  final UserEntity? userEntity;
  final DioException? error;

  const RegisterState({this.userEntity, this.error});

  @override
  List<Object> get props => [userEntity?? '', error??''];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterInProgress extends RegisterState {
  const RegisterInProgress();
}

class RegisteredSuccessfully extends RegisterState {
  const RegisteredSuccessfully(UserEntity userEntity)
      : super(userEntity: userEntity);
}

class RegistrationError extends RegisterState {
  const RegistrationError(DioException error) : super(error: error);
}
