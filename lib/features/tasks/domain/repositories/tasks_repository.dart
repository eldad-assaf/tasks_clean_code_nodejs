import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/create_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/remove_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';

abstract class TasksRepository {
  Future<DataState<List<TaskEntity>>> getAllTasks();
  Future<DataState<TaskEntity>> createTask(
      {required CreateTaskRequest createTaskRequest});

  Future<DataState<TaskEntity>> removeTask(
      {required RemoveTaskRequest removeTaskRequest});
}
