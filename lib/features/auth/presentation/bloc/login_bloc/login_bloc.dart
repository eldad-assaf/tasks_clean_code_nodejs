import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/login_request_data.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/usecases/login_user.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUseCase _loginUserUseCase;
  LoginBloc(this._loginUserUseCase) : super(LoginInitial()) {
    on<LoginUser>(onLoginUser);
  }

  void onLoginUser(LoginUser event, Emitter<LoginState> emit) async {
    final dataState =
        await _loginUserUseCase.call(params: event.loginRequestData);

    if (dataState is DataSucess && dataState.data != null) {
      log('DataSucess from bloc');
      emit(LoggedinSuccessfully(dataState.data!));
    }
    if (dataState is DataFailed) {
      log('DataFailed from bloc');
      emit(LoginError(dataState.error!));
    }
  }
}
