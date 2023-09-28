import 'dart:developer';

import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    int? id,
    String? name,
    bool? completed,
  }) : super(
          id: id,
          name: name,
          completed: completed,
        );

         factory TaskModel.fromJson(Map<String, dynamic> map) {
    log(map.toString());
    return TaskModel(
      id: map['id'],
      name: map['user']['name'] ?? '',
      email: map['user']['email'] ?? '',
      token: map['token'] ?? '',
    );
  }

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
        userUid: entity.userUid,
        name: entity.name ?? '',
        email: entity.email ?? '',
        token: entity.token ?? '');
  }
}




