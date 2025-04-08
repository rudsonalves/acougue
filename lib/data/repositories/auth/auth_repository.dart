import 'package:acougue/domain/models/user.dart';
import 'package:acougue/utils/result.dart';

abstract class AuthRepository {
  User? get user;
  Future<Result<void>> signIn(String userName, String password);
  Future<Result<void>> addUser(User user);
  Future<Result<void>> signOut();
  Future<Result<void>> changePassword(String userName, String password);
}
