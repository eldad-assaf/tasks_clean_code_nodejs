part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class GetTasksEvent extends TasksEvent {
  const GetTasksEvent();
}

class CreateTaskEvent extends TasksEvent {
  final CreateTaskRequest createTaskRequest;

  const CreateTaskEvent(
    this.createTaskRequest,
  );
}

class RemoveTaskEvent extends TasksEvent {
  final RemoveTaskRequest removeTaskRequest;

  const RemoveTaskEvent(
    this.removeTaskRequest,
  );
}