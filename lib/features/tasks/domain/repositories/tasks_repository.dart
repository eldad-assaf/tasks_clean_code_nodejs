import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';

abstract class TasksRepository {
  Future<DataState<List<TaskEntity>>> getAllTasks();
}
