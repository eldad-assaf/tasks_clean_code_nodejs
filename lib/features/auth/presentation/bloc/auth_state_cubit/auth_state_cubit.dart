import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/datasources/local/app_database.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/user_model.dart';
import 'package:store_flutter_clean_code_nodejs/injection_container.dart';

part 'auth_state_state.dart';

class AuthStateCubit extends Cubit<AuthStateState> {
  final AppDatabase _appDatabase;
  final FlutterSecureStorage _flutterSecureStorage;
  final StreamController<bool> _authController;

  AuthStateCubit()
      : _appDatabase = sl(),
        _flutterSecureStorage = sl(),
        _authController = StreamController<bool>(),
        super(AuthStateInitial());

  // Create a private StreamController for authentication

  // Expose the stream to check if the user is authenticated
  Stream<bool> get isAuthenticatedStream => _authController.stream;

  // Implement your authentication logic here and update the stream accordingly
  Stream<bool> isAuthenticated() async* {
    await for (final userModel
        in _appDatabase.userDao.userStreamForAuthState(UserModel.fixedUserId)) {
      if (userModel != null && userModel.token != null) {
        log(userModel.token.toString());
        final x = await _validateToken(tokenFromServer: userModel.token!);
        log(x.toString());
        if (x) {
          log('4');

          yield true;
        }
      } else {
        log('6');
        yield false;
      }
    }
  }

  Future<bool> _validateToken({required String tokenFromServer}) async {
    log('_validateToken');
    final tokenFromDevice = await _flutterSecureStorage.read(key: 'token');
    if (tokenFromDevice == null) {
      log('1');
      return false;
    }
    if (tokenFromServer != tokenFromDevice) {
      log('2');

      return false;
    } else {
      log('3');
      bool hasExpired = JwtDecoder.isExpired(tokenFromDevice);
      log(hasExpired.toString());
      return hasExpired;
    }
  }

  // Dispose of the StreamController when it's no longer needed
  @override
  Future<void> close() {
    _authController.close();
    return super.close();
  }
}
