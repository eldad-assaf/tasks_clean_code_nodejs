import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/core/usecase/usecase.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/register_request.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/repositories/user_repository.dart';

class RegisterUserUseCase
    implements UseCase<DataState<UserEntity>, RegisterRequest> {
  final UserRepository _userRepository;
  RegisterUserUseCase(
    this._userRepository,
  );

  @override
  Future<DataState<UserEntity>> call({RegisterRequest? params}) {
    return _userRepository.registerUser(registerRequestData: params!);
  }
}
