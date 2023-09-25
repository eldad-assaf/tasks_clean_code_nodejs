import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  
  final int? id;
  final String? userUid;
  final String? name;

  const UserEntity({
    this.id,
    this.userUid,
    this.name,
  });

  @override
  List<Object?> get props => [id,userUid, name];
}
