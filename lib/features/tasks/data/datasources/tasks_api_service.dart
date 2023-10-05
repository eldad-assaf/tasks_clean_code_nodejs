import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:store_flutter_clean_code_nodejs/core/constants/constants.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/create_task_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/task_model.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/models/update_task_request.dart';

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

  @POST('/tasks')
  Future<HttpResponse<TaskModel>> createTask(
      @Body() CreateTaskRequest createTaskRequest);


  @DELETE("/tasks/{id}")
  Future<HttpResponse<TaskModel>> removeTask(@Path() String id);

  @PATCH("/tasks/{id}")
  Future<HttpResponse<TaskModel>> updateTask(
      @Path() String id, @Body()UpdateTaskRequest updateTaskRequest   );

  
}
