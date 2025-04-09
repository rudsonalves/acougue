import 'package:acougue/domain/models/credentials.dart';
import 'package:acougue/domain/models/user.dart';
import 'package:acougue/utils/result.dart';

abstract class AuthRepository {
  User? get user;
  Future<Result<User>> initialize();
  Future<Result<void>> signIn(Credentials credentials);
  Future<Result<void>> addUser(User user);
  Future<Result<void>> signOut();
  Future<Result<void>> changePassword(String password);
  Future<Result<void>> updateUser(User user);
}
