import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/datasources/local/app_database.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/datasources/user_api_service.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/repositories/user_repository_impl.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/repositories/user_repository.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/usecases/login_user.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/usecases/logout_user.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/usecases/register_user.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/datasources/tasks_api_service.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/data/repositories/tasks_repository_impl.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/repositories/tasks_repository.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/usecases/create_task.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/usecases/get_all_tasks.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/usecases/remove_task.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/domain/usecases/update_task.dart';
import 'package:store_flutter_clean_code_nodejs/features/tasks/presentation/bloc/tasks_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton(database);
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());

  //Dependencies
  sl.registerSingleton<UserApiService>(UserApiService(sl()));
  sl.registerSingleton<UserRepository>(UserRepositoryImpl(sl(), sl(), sl()));
  sl.registerSingleton<TasksApiService>(TasksApiService(sl()));
  sl.registerSingleton<TasksRepository>(TasksRepositoryImpl(sl(), sl()));

  //UseCases
  sl.registerSingleton<RegisterUserUseCase>(RegisterUserUseCase(sl()));
  sl.registerSingleton<LoginUserUseCase>(LoginUserUseCase(sl()));
  sl.registerSingleton<LogoutUserUseCase>(LogoutUserUseCase(sl()));
  sl.registerSingleton<GetAllTasksUsecase>(GetAllTasksUsecase(sl()));
  sl.registerSingleton<CreateTaskUsecase>(CreateTaskUsecase(sl()));
  sl.registerSingleton<RemoveTaskUsecase>(RemoveTaskUsecase(sl()));
  sl.registerSingleton<UpdateTaskUsecase>(UpdateTaskUsecase(sl()));

  //Blocs
  sl.registerFactory<RegisterBloc>(() => RegisterBloc(sl()));
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl(), sl()));
  sl.registerFactory<TasksBloc>(() => TasksBloc(sl(), sl(), sl(), sl()));
}
