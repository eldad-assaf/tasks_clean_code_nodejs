part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterUser extends RegisterEvent {
  final RegisterRequestData? registerRequestData;

  const RegisterUser(this.registerRequestData);
  
  @override
  List<Object?> get props => [registerRequestData];
}
