import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/datasources/local/app_database.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/datasources/user_api_service.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/login_request_data.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/register_request_data.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/user_model.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApiService _userApiService;
  final AppDatabase _appDatabase;
  UserRepositoryImpl(
    this._userApiService,
    this._appDatabase,
  );

  @override
  Future<DataState<UserModel>> registerUser(
      {required RegisterRequestData registerRequestData}) async {
    try {
      final httpResponse = await _userApiService.registerUser(
          registerRequestData, 'application/json');

      if (httpResponse.response.statusCode == HttpStatus.created) {
        try {
          await _appDatabase.userDao.insertPerson(UserModel(
            id: httpResponse.data.id,
            userUid: httpResponse.data.id.toString(),
            name: httpResponse.data.name,
          ));

          final z = await _appDatabase.userDao.findAllPeople();
          log(z.toString());
        } catch (e) {
          log(e.toString());
        }

        //
        // final dbUser = await _appDatabase.userDao.findUserModelById(1);
        //final dbUser = await _appDatabase.userDao.getPeopleCount();

        // log('${dbUser!.databaseId}');
        // log('${dbUser.id}');
        // log('${dbUser.name}');

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

  @override
  Future<DataState<UserEntity>> loginUser(
      {required LoginRequestData loginRequestData}) async {
    try {
      final httpResponse =
          await _userApiService.loginUser(loginRequestData, 'application/json');

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
