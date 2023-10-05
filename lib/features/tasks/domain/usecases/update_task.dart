import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/core/usecase/usecase.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/update_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/repositories/tasks_repository.dart';

class UpdateTaskUsecase
    implements UseCase<DataState<TaskEntity>, UpdateTaskRequest> {
  final TasksRepository _tasksRepository;
  UpdateTaskUsecase(
    this._tasksRepository,
  );
  @override
  Future<DataState<TaskEntity>> call({UpdateTaskRequest? params}) {
     return _tasksRepository.updateTask(updateTaskRequest: params!);
  }
}
