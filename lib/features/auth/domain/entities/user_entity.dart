import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? userUid;
  final String? name;
  final String? email;
  final String? token;


  const UserEntity({
    this.id,
    this.userUid,
    this.name,
    this.email,
    this.token,
  });

  @override
  List<Object?> get props => [id, userUid, name,email,token];
}
