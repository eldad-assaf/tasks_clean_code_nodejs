import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/register_request_data.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<DataState<UserEntity>> registerUser(
      {required RegisterRequestData registerRequestData});
}
