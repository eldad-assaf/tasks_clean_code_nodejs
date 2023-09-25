// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/user_model.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM user')
  Future<List<UserModel>> findAllPeople();

  @Query('SELECT name FROM user')
  Stream<List<String>> findAllPeopleName();

  @Query('SELECT * FROM user WHERE id = :id')
  Stream<UserModel?> findPersonById(int id);

  @insert
  Future<void> insertPerson(UserModel user);
}