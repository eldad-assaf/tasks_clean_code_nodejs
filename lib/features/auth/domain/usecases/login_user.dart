import 'package:store_flutter_clean_code_nodejs/core/resources/data_state.dart';
import 'package:store_flutter_clean_code_nodejs/core/usecase/usecase.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/data/models/login_request_data.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/entities/user_entity.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/repositories/user_repository.dart';

class LoginUserUseCase
    implements UseCase<DataState<UserEntity>, LoginRequestData> {
  final UserRepository _userRepository;
  LoginUserUseCase(
    this._userRepository,
  );

  @override
  Future<DataState<UserEntity>> call({LoginRequestData? params}) {
    return _userRepository.loginUser(loginRequestData: params!);
  }
}
