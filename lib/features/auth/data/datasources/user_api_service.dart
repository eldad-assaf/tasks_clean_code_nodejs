import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:store_flutter_clean_code_nodejs/core/constants/constants.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/register_request_data.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/user_model.dart';

part 'user_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class UserApiService {
  factory UserApiService(Dio dio) = _UserApiService;

  @POST("/auth/register")
  Future<HttpResponse<UserModel>> registerUser(
      @Body() RegisterRequestData registerRequestData,
      @Header("Content-Type") String contentType);
}
