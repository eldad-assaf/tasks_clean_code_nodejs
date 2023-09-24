import 'dart:developer';

import 'package:store_flutter_clean_code_nodejs/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    int? id,
    String? name,
  }) : super(id: id, name: name);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    log(map.toString());
    int? id;
    if (map['id'] is int) {
      id = map['id'] as int; // If 'id' is already an integer, use it.
    } else if (map['id'] is String) {
      id =
          int.tryParse(map['id'] as String); // Try to parse 'id' as an integer.
    }
    log('id:$id');
    return UserModel(
      id: id,
      name: map['user']['name'] ?? '',
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name ?? '',
    );
  }
}


// {
//     "user": {
//         "name": "Eldadds21"
//     },
//     "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTEwNzQ0MWQ5NWY4NzQwYzg0NDQ2MDAiLCJuYW1lIjoiRWxkYWRkczIxIiwiaWF0IjoxNjk1NTc3MTUzLCJleHAiOjE2OTgxNjkxNTN9.93msgSzNrGnaH0iS4EAgej8cf1CRUreoIg9SN0YVAfE",
//     "id": "65107441d95f8740c8444600"
// }