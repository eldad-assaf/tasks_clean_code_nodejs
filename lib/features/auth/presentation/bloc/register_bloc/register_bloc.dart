import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/register_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/usecases/register_user.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUseCase _registerUserUseCase;
  RegisterBloc(this._registerUserUseCase) : super(RegisterInitial()) {
    on<RegisterUserEvent>(onRegisterUser);
  }

  void onRegisterUser(
      RegisterUserEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterInProgress());
    try {
      final dataState =
          await _registerUserUseCase.call(params: event.registerRequest);

      if (dataState is DataSuccess && dataState.data != null) {
        log('DataSucess from bloc');

        emit(RegisteredSuccessfully(dataState.data!));
      }
      if (dataState is DataFailed) {
        print('DataFailed from bloc');
        
        print('Error on RegisterBloc : ${dataState.error!.response!.data!['msg']} ');
        emit(RegistrationError(dataState.error!));
      }
    } catch (e) {
      log('Unknows Bloc Error');
      emit(RegisterInitial());
    }
  }
}
