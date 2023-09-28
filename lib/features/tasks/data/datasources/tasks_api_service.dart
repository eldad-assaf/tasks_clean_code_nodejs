import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:store_flutter_clean_code_nodejs/core/constants/constants.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/task_model.dart';

part 'tasks_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class TasksApiService {
  factory TasksApiService(Dio dio) = _TasksApiService;

  @GET("/tasks/")
  Future<HttpResponse<List<TaskModel>>> getAllTasks(
      @Header("Content-Type") String contentType,
      @Header("Authorization")
      String accessToken // Add this line to include the access token header
      );
}
