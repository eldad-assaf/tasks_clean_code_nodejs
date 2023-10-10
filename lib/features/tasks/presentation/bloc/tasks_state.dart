part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  final List<TaskEntity>? tasks;
  final DioException? error;

  const TasksState({this.tasks, this.error});
  @override
  List<Object?> get props => [tasks, error];
}

final class TasksInitial extends TasksState {}

final class TasksLoading extends TasksState {}

final class TasksLoaded extends TasksState {
  const TasksLoaded(List<TaskEntity> tasks) : super(tasks: tasks);
}

final class TasksError extends TasksState {
  const TasksError(DioException error) : super(error: error);
}




