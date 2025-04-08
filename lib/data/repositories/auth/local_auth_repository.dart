import 'dart:developer';

import 'package:acougue/domain/models/credentials.dart';

import '/data/repositories/auth/auth_repository.dart';
import '../../services/json_service.dart';
import '/domain/models/user.dart';
import '/utils/result.dart';

class LocalAuthRepository implements AuthRepository {
  final JsonService _database;

  LocalAuthRepository(this._database);

  User? _user;

  @override
  User? get user => _user;

  @override
  Future<Result<User>> initialize() async {
    try {
      await _database.open();
      final usersMap = _database.usersMap.values;
      final users = usersMap.map((map) => User.fromMap(map)).toList();

      if (users.length != 1 || users.first.name != 'admin') {
        throw Exception('Don\'t do auto login.');
      }

      final user = await _database.signIn('admin', users.first.password!);
      if (user == null) {
        throw Exception('login fail');
      }

      return Result.success(user);
    } on Exception catch (err) {
      _user = null;
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<User>> signIn(Credentials credentials) async {
    try {
      _user = await _database.signIn(credentials.name, credentials.password);

      return Result.success(_user!);
    } on Exception catch (err) {
      _user = null;
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> changePassword(String password) async {
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
