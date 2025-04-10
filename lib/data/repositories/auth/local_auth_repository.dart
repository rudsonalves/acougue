import 'dart:developer';

import 'package:acougue/domain/models/credentials.dart';

import '/data/repositories/auth/auth_repository.dart';
import '../../services/json_service.dart';
import '/domain/models/user.dart';
import '/utils/result.dart';

class LocalAuthRepository implements AuthRepository {
  final JsonService _jsonServer;

  LocalAuthRepository(this._jsonServer);

  User? _user;

  @override
  User? get user => _user;

  @override
  Future<Result<User>> initialize() async {
    try {
      await _jsonServer.open();
      final usersMap = _jsonServer.usersMap.values;
      final users = usersMap.map((map) => User.fromMap(map)).toList();

      if (users.length != 1 || users.first.name != 'admin') {
        throw Exception('Don\'t do auto login.');
      }

      _user = await _jsonServer.signIn('admin', users.first.password!);
      if (_user == null) {
        throw Exception('login fail');
      }

      return Result.success(_user!);
    } on Exception catch (err) {
      _user = null;
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<User>> signIn(Credentials credentials) async {
    try {
      _user = await _jsonServer.signIn(credentials.name, credentials.password);

      if (_user == null) {
        return Result.failure(Exception('login fail'));
      }

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
      await _jsonServer.updateUser(newUser);

      return const Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> updateUser(User user) async {
    try {
      final response = await _jsonServer.updateUser(user);
      if (!response) {
        throw Exception('update fail');
      }

      return const Result.success(null);
    } on Exception catch (err) {
      _user = null;
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      _user = null;
      await _jsonServer.signOut();
      return const Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> addUser(User user) async {
    try {
      await _jsonServer.addUser(user);
      return const Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }
}
