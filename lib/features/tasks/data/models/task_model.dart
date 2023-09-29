
import 'package:json_annotation/json_annotation.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel extends TaskEntity {
  TaskModel({
    String? id,
    String? name,
    bool? completed,
  }) : super(id: id, name: name, completed: completed);

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      name: entity.name,
      completed: entity.completed,
    );
  }
}
