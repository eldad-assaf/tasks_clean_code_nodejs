import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';

//part 'task_model.g.dart';

@JsonSerializable()
class TaskModel extends TaskEntity {
  TaskModel({
    String? id,
    String? name,
    bool? completed,
  }) : super(id: id, name: name, completed: completed);

  // factory TaskModel.fromJson(Map<String, dynamic> json) =>
  //     _$TaskModelFromJson(json);

  // Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    log('json responde : ${map}');
    log('${map['_id']}');
    log('${map['name']}');
    log('${map['completed']}');

    final TaskModel model = TaskModel(
        id: map['_id'], name: map['name'], completed: map['completed']);
    log('model : ${model}');
    return model;
    // return TaskModel(
    //     id: map['id'], name: map['name'], completed: map['completed']);
  }

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      name: entity.name,
      completed: entity.completed,
    );
  }
}
