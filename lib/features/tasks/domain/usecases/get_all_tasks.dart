import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/core/usecase/usecase.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/task_model.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/repositories/tasks_repository.dart';

class GetAllTasksUsecase implements UseCase<DataState<List<TaskEntity>>, void> {
  final TasksRepository _tasksRepository;
  GetAllTasksUsecase(this._tasksRepository);
  @override
  Future<DataState<List<TaskEntity>>> call({void params}) {
    return _tasksRepository.getAllTasks();
  }
}
