import 'dart:developer';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    String? id,
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
        id: map['id'], name: map['name'], completed: map['completed']);
  }

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      name: entity.name,
      completed: entity.completed,
    );
  }
}
