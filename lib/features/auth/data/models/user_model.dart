import 'dart:developer';

import 'package:floor/floor.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/entities/user_entity.dart';

@Entity(tableName: 'user', primaryKeys: ['id'])
class UserModel extends UserEntity {
  static const int fixedUserId = 1; // Fixed user ID.

  const UserModel({
    String? userUid,
    String? name,
    String? email,
    String? token,
  }) : super(
          id: fixedUserId,
          userUid: userUid,
          name: name,
          email: email,
          token: token,
        );

  factory UserModel.fromJson(Map<String, dynamic> map) {
    log(map.toString());
    return UserModel(
      userUid: map['id'],
      name: map['user']['name'] ?? '',
      email: map['user']['email'] ?? '',
      token: map['token'] ?? '',
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
        userUid: entity.userUid,
        name: entity.name ?? '',
        email: entity.email ?? '',
        token: entity.token ?? '');
  }
}
