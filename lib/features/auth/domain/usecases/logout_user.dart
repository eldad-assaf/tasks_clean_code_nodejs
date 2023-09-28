import 'package:store_flutter_clean_code_nodejs/core/usecase/usecase.dart';
import 'package:store_flutter_clean_code_nodejs/features/auth/domain/repositories/user_repository.dart';

class LogoutUserUseCase
    implements UseCase<bool, void> {
  final UserRepository _userRepository;
  LogoutUserUseCase(
    this._userRepository,
  );

  @override
  Future<bool> call({void params}) {
    return _userRepository.logoutUser();
  }
}
