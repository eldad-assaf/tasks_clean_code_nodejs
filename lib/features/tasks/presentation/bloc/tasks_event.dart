part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}


class GetTasks extends TasksEvent {
  const GetTasks();
}