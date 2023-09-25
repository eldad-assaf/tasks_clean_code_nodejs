// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:store_flutter_clean_code_nodejs/features/auth/data/datasources/local/DAO/user_dao.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/user_model.dart';


part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [UserModel])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
}