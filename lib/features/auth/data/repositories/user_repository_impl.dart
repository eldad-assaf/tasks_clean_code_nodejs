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
          log(httpResponse.data.userUid.toString());
          log(httpResponse.data.name.toString());

          final user = UserModel(
              userUid: httpResponse.data.userUid, name: httpResponse.data.name);
          log('user object to insert on DB ${user.userUid}');
          await userToDb(userModel: user);
          //await _appDatabase.userDao.insertUser(user);
        } catch (e) {
          log(e.toString());
        }

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

  Future<void> userToDb({required UserModel userModel}) async {
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
  Future<UserModel?> getUserDataFromDB() async {
    final _currentUser =
        await _appDatabase.userDao.findUser(UserModel.fixedUserId);
    if (_currentUser != null) {
      log('_currentUser : ${_currentUser.userUid}');
    }
    return _currentUser;
  }

//works
  // @override
  // Future<void> getUserDataFromDB() async {
  //   try {
  //     final allUsers = await _appDatabase.userDao.getAllUsers();
  //     log('all users length : ${allUsers.length}');

  //     log('first user id: ${allUsers[0].id}');
  //     log('first user userUid: ${allUsers[0].userUid}');
  //     log('first user name: ${allUsers[0].name}');
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  // @override
  // Future<UserModel?> getUserDataFromDB() async {
  //   try {
  //     final userData = await _appDatabase.userDao.getUserData();
  //     if (userData != null) {
  //       log('userData : ${userData.id}');
  //       log('userData : ${userData.userUid}');
  //       log('userData : ${userData.name}');
  //       return userData;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return null;
  // }
}
