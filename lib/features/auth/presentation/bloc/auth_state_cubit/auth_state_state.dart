part of 'auth_state_cubit.dart';

abstract class AuthStateState extends Equatable {
  final bool? isAuthenticated;
  const AuthStateState({this.isAuthenticated});

  @override
  List<Object> get props => [isAuthenticated ?? false];
}

final class AuthStateInitial extends AuthStateState {}

final class AuthStateLoading extends AuthStateState {}

final class AuthStateAuthenticated extends AuthStateState {
  const AuthStateAuthenticated(bool? isAuthenticated)
      : super(isAuthenticated: isAuthenticated);
}

final class AuthStateUnauthenticated extends AuthStateState {}
