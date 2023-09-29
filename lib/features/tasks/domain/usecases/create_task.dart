import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/core/usecase/usecase.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/create_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/repositories/tasks_repository.dart';

class CreateTaskUsecase
    implements UseCase<DataState<TaskEntity>, CreateTaskRequest> {
  final TasksRepository _tasksRepository;
  CreateTaskUsecase(
    this._tasksRepository,
  );
  @override
  Future<DataState<TaskEntity>> call({CreateTaskRequest? params}) {
    return _tasksRepository.createTask(createTaskRequest: params!);
  }
}
