import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/datasources/local/app_database.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/datasources/user_api_service.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/login_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/register_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/user_model.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApiService _userApiService;
  final AppDatabase _appDatabase;
  final FlutterSecureStorage _flutterSecureStorage;
  UserRepositoryImpl(
    this._userApiService,
    this._appDatabase,
    this._flutterSecureStorage,
  );

  @override
  Future<DataState<UserModel>> registerUser({
    required RegisterRequest registerRequestData,
  }) async {
    print('registerUser');
    try {
      final httpResponse = await _userApiService.registerUser(
        registerRequestData,
        'application/json',
      );

      if (httpResponse.response.statusCode == HttpStatus.created) {
        final user = UserModel(
          userUid: httpResponse.data.userUid,
          name: httpResponse.data.name,
          email: httpResponse.data.email,
          token: httpResponse.data.token,
        );

        // Save user details to local DB and secure storage
        await saveUserInLocalDb(userModel: user);
        await saveUserTokenToSecureStorage(token: user.token!);

        return DataSuccess(httpResponse.data);
      } else {
        print('error');
        // print(httpResponse.response.statusMessage);
        print(httpResponse.response);
        //   print(httpResponse.response.statusMessage);

        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
    
      print('${e.response!.data}');

      return DataFailed(e);
    } catch (e) {
      return DataFailed(DioException(
        error: 'An unexpected error occurred',
        type: DioExceptionType.unknown,
        requestOptions: RequestOptions(),
      ));
    }
  }

  @override
  Future<DataState<UserModel>> loginUser({
    required LoginRequest loginRequestData,
  }) async {
    try {
      final httpResponse = await _userApiService.loginUser(
        loginRequestData,
        'application/json',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print('ok');
        print('${httpResponse.data.email}');
        final user = UserModel(
          userUid: httpResponse.data.userUid,
          name: httpResponse.data.name,
          email: httpResponse.data.email,
          token: httpResponse.data.token,
        );

        // Save user details to local DB and secure storage
        try {
          await saveUserInLocalDb(userModel: user);
          await saveUserTokenToSecureStorage(token: user.token!);
        } catch (e) {
          log(e.toString());
        }

        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    } catch (e) {
      log(e.toString());
      return DataFailed(
        DioException(
          error: 'An unexpected error occurred',
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions(),
        ),
      );
    }
  }

  @override
  Future<void> saveUserInLocalDb({required UserModel userModel}) async {
// Check if the user with the fixed ID exists.
    final existingUser =
        await _appDatabase.userDao.findUser(UserModel.fixedUserId);

    if (existingUser != null) {
      // User already exists, update their information.
      await _appDatabase.userDao.updateUser(userModel);
    } else {
      // User doesn't exist, insert a new user with the fixed ID.
      await _appDatabase.userDao.insertUser(userModel);
    }
  }

  @override
  Future<UserModel?> getUserFromLocalDb() async {
    final _currentUser =
        await _appDatabase.userDao.findUser(UserModel.fixedUserId);
    if (_currentUser != null) {
      log('_currentUser : ${_currentUser.userUid}');
    }
    return _currentUser;
  }

  @override
  Future<void> saveUserTokenToSecureStorage({required String token}) async {
    try {
      await _flutterSecureStorage.write(key: 'token', value: token);
    } catch (e) {
      log('error saving token');
    }
  }

  @override
  Future<String?> getUserTokenFromSecureStorage() async {
    final token = await _flutterSecureStorage.read(key: 'token');
    return token;
  }

  @override
  Future<bool> logoutUser() async {
    try {
      await _appDatabase.userDao.deleteUser();
      await _flutterSecureStorage.delete(key: 'token');
      return true;
    } catch (e) {
      log('error on logoutUser ${e.toString()}');
      return false;
    }
  }
}
