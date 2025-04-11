import 'package:acougue/domain/dto/user_info.dart';

import '/domain/dto/credentials.dart';
import '/domain/models/user.dart';
import '/utils/result.dart';

abstract class AuthRepository {
  User? get user;
  List<UserInfo> get listUserInfo;

  UserInfo? getUserInfo(String id);
  Future<Result<User>> initialize();
  Future<Result<void>> signIn(Credentials credentials);
  Future<Result<void>> addUser(User user);
  Future<Result<User>> getUser(String id);
  Future<Result<void>> signOut();
  Future<Result<void>> changePassword(String password);
  Future<Result<void>> updateUser(User user);
}
