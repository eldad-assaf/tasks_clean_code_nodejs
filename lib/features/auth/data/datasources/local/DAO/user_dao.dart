// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/user_model.dart';

@dao
abstract class UserDao {
  @Insert()
  Future<void> insertUser(UserModel user);

  @Query('SELECT * FROM user')
  Future<List<UserModel>> getAllUsers();
}