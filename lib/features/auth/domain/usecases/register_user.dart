import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/core/usecase/usecase.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/register_request_data.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/repositories/user_repository.dart';

class RegisterUserUseCase implements UseCase<DataState<UserEntity>, RegisterRequestData> {
  final UserRepository _userRepository;
  RegisterUserUseCase(
    this._userRepository,
  );

  @override
  Future<DataState<UserEntity>> call({RegisterRequestData? params}) {
    return _userRepository.registerUser(registerRequestData: params!);
  }
}
