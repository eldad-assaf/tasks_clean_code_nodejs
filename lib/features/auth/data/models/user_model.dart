import 'package:floor/floor.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/entities/user_entity.dart';

@Entity(tableName: 'user', primaryKeys: ['id'])
class UserModel extends UserEntity {
  const UserModel({
    int? id,
    String? userUid,
    String? name,
  }) : super(id: id, userUid: userUid, name: name);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      userUid: map['id'],
      name: map['user']['name'] ?? '',
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      userUid: entity.userUid,
      name: entity.name ?? '',
    );
  }
}
