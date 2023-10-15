import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/create_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/remove_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/update_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/usecases/create_task.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/usecases/get_all_tasks.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/usecases/remove_task.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/usecases/update_task.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetAllTasksUsecase _getAllTasksUsecase;
  final CreateTaskUsecase _createTaskUsecase;
  final RemoveTaskUsecase _removeTaskUsecase;
  final UpdateTaskUsecase _updateTaskUsecase;
  TasksBloc(this._getAllTasksUsecase, this._createTaskUsecase,
      this._removeTaskUsecase, this._updateTaskUsecase)
      : super(TasksLoading()) {
    on<GetTasksEvent>(onGetTasks);
    on<CreateTaskEvent>(onCreateTask);
    on<RemoveTaskEvent>(onRemoveTask);
    on<UpdateTaskEvent>(onUpdateTask);
  }

  void onGetTasks(GetTasksEvent event, Emitter<TasksState> emit) async {
    final dataState = await _getAllTasksUsecase();
    if (dataState is DataSuccess && dataState.data != null) {
      emit(TasksLoaded(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(TasksError(dataState.error!));
    }
  }

  void onCreateTask(CreateTaskEvent event, Emitter<TasksState> emit) async {
    final dataState = await _createTaskUsecase(params: event.createTaskRequest);
    if (dataState is DataSuccess && dataState.data != null) {
      log('ok : ${dataState.data!.name}');
      log('ok : ${dataState.data!.id}');
      log('ok : ${dataState.data!.completed}');

      add(GetTasksEvent());
    }
    if (dataState is DataFailed) {
      print('DataFailed from tasksbloc');
      print('error :${dataState.error!.response!.data['msg']}');//token is missing

      emit(TasksError(dataState.error!));
    }
  }

  void onRemoveTask(RemoveTaskEvent event, Emitter<TasksState> emit) async {
    final dataState = await _removeTaskUsecase(params: event.removeTaskRequest);
    if (dataState is DataSuccess && dataState.data != null) {
      log('ok : ${dataState.data!.name}');
      log('ok : ${dataState.data!.id}');
      log('ok : ${dataState.data!.completed}');

      add(GetTasksEvent());
    }
    if (dataState is DataFailed) {
      log('DataFailed from tasksbloc');
      log(dataState.error.toString());

      log(dataState.error!.type.toString());

      emit(TasksError(dataState.error!));
    }
  }

  void onUpdateTask(UpdateTaskEvent event, Emitter<TasksState> emit) async {
    final dataState = await _updateTaskUsecase(params: event.updateTaskRequest);
    if (dataState is DataSuccess && dataState.data != null) {
      add(GetTasksEvent());
    }
    if (dataState is DataFailed) {
      emit(TasksError(dataState.error!));
    }
  }
}
