import 'package:acougue/utils/result.dart';

abstract class AuthRepository {
  Future<Result<void>> signIn(String userName, String password);
  Future<Result<void>> signUp(String userName, String password);
  Future<Result<void>> signOut();
  Future<Result<void>> changePassword(String userName, String password);
}
