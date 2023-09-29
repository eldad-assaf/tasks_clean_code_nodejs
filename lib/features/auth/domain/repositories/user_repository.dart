import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/login_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/register_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/user_model.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<DataState<UserEntity>> registerUser(
      {required RegisterRequest registerRequestData});

  Future<DataState<UserEntity>> loginUser(
      {required LoginRequest loginRequestData});

  Future<bool> logoutUser();

  Future<void> saveUserInLocalDb({required UserModel userModel});
  Future<UserModel?> getUserFromLocalDb();

  Future<void> saveUserTokenToSecureStorage({required String token});
  Future<String?> getUserTokenFromSecureStorage();
}
