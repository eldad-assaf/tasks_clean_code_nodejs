part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterUserEvent extends RegisterEvent {
  final RegisterRequest? registerRequest;

  const RegisterUserEvent(this.registerRequest);

  @override
  List<Object?> get props => [registerRequest];
}
