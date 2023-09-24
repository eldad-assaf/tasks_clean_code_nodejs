import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/datasources/user_api_service.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/register_request_data.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/user_model.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApiService _userApiService;
  UserRepositoryImpl(
    this._userApiService,
  );

  @override
  Future<DataState<UserModel>> registerUser(
      {required RegisterRequestData registerRequestData}) async {
    try {
      final httpResponse = await _userApiService.registerUser(
          registerRequestData, 'application/json');
      log(httpResponse.response.toString());
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSucess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
