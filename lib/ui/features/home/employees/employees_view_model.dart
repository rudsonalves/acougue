import '/data/repositories/auth/auth_repository.dart';
import '/domain/dto/user_info.dart';
import '/domain/models/user.dart';

class EmployeesViewModel {
  final AuthRepository _authRepository;

  EmployeesViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository;

  User get user => _authRepository.user!;

  List<UserInfo> get listUserInfo => _authRepository.listUserInfo;
  UserInfo? getUserInfo(String id) => _authRepository.getUserInfo(id);
}
