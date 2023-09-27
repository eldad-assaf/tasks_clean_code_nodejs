import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
      if (userModel != null) {
        log(userModel.email.toString());
        yield true;
      } else {
        log('null');
        yield false;
      }
    }
  }

  // Dispose of the StreamController when it's no longer needed
  @override
  Future<void> close() {
    _authController.close();
    return super.close();
  }
}
