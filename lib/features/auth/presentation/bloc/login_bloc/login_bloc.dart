import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/login_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/usecases/login_user.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/usecases/logout_user.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUseCase _loginUserUseCase;
  final LogoutUserUseCase _logoutUserUseCase;
  LoginBloc(this._loginUserUseCase, this._logoutUserUseCase)
      : super(LoginInitial()) {
    on<LoginUserEvent>(onLoginUser);
    on<LogoutUserEvent>(onLogoutUser);
  }

  void onLoginUser(LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(LoginInProgress());
    final dataState = await _loginUserUseCase.call(params: event.loginRequest);

    if (dataState is DataSuccess && dataState.data != null) {
      log('DataSucess from bloc');
      emit(LoggedinSuccessfully(dataState.data!));
    }
    if (dataState is DataFailed) {
      log('DataFailed from bloc');
      emit(LoginError(dataState.error!));
    }
  }

  void onLogoutUser(LogoutUserEvent event, Emitter<LoginState> emit) async {
    emit(LogoutInProgress());
    final logoutSuccess = await _logoutUserUseCase.call();
    if (logoutSuccess) {
      emit(LogoutSuccessfully());
    } else {
      emit((LogoutError()));
    }
  }
}
