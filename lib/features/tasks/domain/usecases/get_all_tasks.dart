import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/core/usecase/usecase.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/task_model.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/repositories/tasks_repository.dart';

class GetAllTasks implements UseCase<DataState<List<TaskEntity>>, void> {
  final TaskRepository _taskRepository;
  GetAllTasks(this._taskRepository);
  @override
  Future<DataState<List<TaskEntity>>> call({void params}) {
    return _taskRepository.getAllTasks();
  }
}
