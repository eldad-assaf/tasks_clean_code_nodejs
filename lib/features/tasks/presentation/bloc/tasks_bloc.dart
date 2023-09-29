import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/entities/task_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/usecases/get_all_tasks.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  // final GetArticleUseCase _articleUseCase;
  final GetAllTasksUsecase _getAllTasksUsecase;
  TasksBloc(this._getAllTasksUsecase) : super(TasksLoading()) {
    on<GetTasks>(onGetTasks);
  }

  void onGetTasks(GetTasks event, Emitter<TasksState> emit) async {
    final dataState = await _getAllTasksUsecase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
   

      emit(TasksLoaded(dataState.data!));
    }
    if (dataState is DataFailed) {
      log('DataFailed from tasksbloc');
      emit(TasksError(dataState.error!));
    }
  }
}
