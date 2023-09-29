import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/datasources/tasks_api_service.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/task_model.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/repositories/tasks_repository.dart';

class TasksRepositoryImpl extends TasksRepository {
  final TasksApiService _tasksApiService;
  final FlutterSecureStorage _flutterSecureStorage;
  TasksRepositoryImpl(this._tasksApiService, this._flutterSecureStorage);

  @override
  Future<DataState<List<TaskModel>>> getAllTasks() async {
    try {
      //get the access token
      final token = await _flutterSecureStorage.read(key: 'token');
      if (token == null) {
        return DataFailed(
          DioException(
            error: 'An unexpected error occurred',
            type: DioExceptionType.unknown,
            requestOptions: RequestOptions(),
          ),
        );
      }
      final httpResponse =
          await _tasksApiService.getAllTasks('application/json', token);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      log(e.toString());
      return DataFailed(e);
    }
  }
}