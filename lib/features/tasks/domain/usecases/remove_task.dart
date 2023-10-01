import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/core/usecase/usecase.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/remove_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/repositories/tasks_repository.dart';

class RemoveTaskUsecase
    implements UseCase<DataState<TaskEntity>, RemoveTaskRequest> {
  final TasksRepository _tasksRepository;
  RemoveTaskUsecase(
    this._tasksRepository,
  );
  @override
  Future<DataState<TaskEntity>> call({RemoveTaskRequest? params}) {
    return _tasksRepository.removeTask(removeTaskRequest: params!);
  }
}
