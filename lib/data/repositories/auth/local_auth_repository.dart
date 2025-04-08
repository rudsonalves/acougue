import 'dart:developer';

import '/data/repositories/auth/auth_repository.dart';
import '/data/services/json_database_service.dart';
import '/domain/models/user.dart';
import '/utils/result.dart';

class LocalAuthRepository implements AuthRepository {
  final JsonDatabaseService _database;

  LocalAuthRepository(this._database);

  User? _user;

  @override
  User? get user => _user;

  @override
  Future<Result<User>> signIn(String userName, String password) async {
    try {
      _user = await _database.signIn(userName, password);

      return Result.success(_user!);
    } on Exception catch (err) {
      _user = null;
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> changePassword(String userName, String password) async {
    try {
      if (_user == null) {
        throw Exception('only owner can change your password');
      }

      final newUser = _user!.copyWith(password: password);
      await _database.updateUser(newUser);

      return Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      _user = null;
      await _database.signOut();
      return Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> addUser(User user) async {
    try {
      await _database.addUser(user);
      return Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }
}
