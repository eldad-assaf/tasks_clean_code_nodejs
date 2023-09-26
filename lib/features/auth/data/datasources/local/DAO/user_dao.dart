// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/user_model.dart';

@dao
abstract class UserDao {
  // @Query('SELECT * FROM user')
  // Future<List<UserModel>> getAllUsers();//works

  @Query('SELECT * FROM user WHERE id = :fixedUserId')
  Future<UserModel?> findUser(int fixedUserId);

  @insert
  Future<void> insertUser(UserModel user);

  @update
  Future<void> updateUser(UserModel user);
}

