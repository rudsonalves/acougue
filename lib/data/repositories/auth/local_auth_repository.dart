import '/utils/logger.dart';
import '/domain/dto/user_info.dart';
import '/domain/enums/enums.dart';
import '/domain/dto/credentials.dart';
import '/data/repositories/auth/auth_repository.dart';
import '../../services/json_service.dart';
import '/domain/models/user.dart';
import '/utils/result.dart';

class LocalAuthRepository implements AuthRepository {
  final JsonService _jsonServer;

  LocalAuthRepository(this._jsonServer);

  User? _user;

  final Map<String, UserInfo> _usersInfo = {};

  final logger = Logger('LocalAuthRepository');

  @override
  List<UserInfo> get listUserInfo => _usersInfo.values.toList();

  @override
  UserInfo? getUserInfo(String id) => _usersInfo[id];

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
      logger.critical('initialize', err);
      return Result.failure(err);
    } finally {
      await _updateUserInfo();
    }
  }

  /// Fetches all user information from the JSON database and updates
  /// the local cache with user info entries mapped by user ID.
  ///
  /// This method clears the existing user info map and repopulates it
  /// by converting the raw user data maps into `UserInfo` objects.
  Future<void> _updateUserInfo() async {
    final usersMap = await _jsonServer.getAllFromCollection('users');

    _usersInfo.clear();

    _usersInfo.addEntries(
      usersMap.map(
        (map) =>
            MapEntry(map['id'] as String, UserInfo.fromUser(User.fromMap(map))),
      ),
    );
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
      logger.critical('signIn', err);
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
      logger.critical('changePassword', err);
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

      _updateUserInfo();
      return const Result.success(null);
    } on Exception catch (err) {
      _user = null;
      logger.critical('updateUser', err);
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
      logger.critical('signOut', err);
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> addUser(User user) async {
    try {
      await _jsonServer.addUser(user);

      _updateUserInfo();
      return const Result.success(null);
    } on Exception catch (err) {
      logger.critical('addUser', err);
      return Result.failure(err);
    }
  }

  @override
  Future<Result<User>> getUser(String id) async {
    try {
      // Only logged user can excecute getUser
      if (_user == null) {
        throw Exception('user not logged in');
      }

      final userPos = _user!.position;

      // Only admin or manager can execute getUser
      if (userPos != Positions.admin && userPos != Positions.manager) {
        throw Exception('only admin can get user info');
      }

      // Get user in id
      final map = await _jsonServer.getFromCollection('users', id);
      final user = User.fromMap(map);

      // Only admin can get admin user
      if (user.position == Positions.admin && userPos != Positions.admin) {
        throw Exception('only admin can get admin user');
      }

      return Result.success(_user!);
    } on Exception catch (err) {
      logger.critical('getUser', err);
      return Result.failure(err);
    }
  }
}
