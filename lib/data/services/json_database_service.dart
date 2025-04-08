import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:developer';

import '/utils/validate.dart';
import '/data/repositories/common/collections.dart';
import '/domain/enums/enums.dart';
import '/domain/models/user.dart';

/// JsonDatabase by Rudson Ribeiro Alves.
/// 2025/04/07
///
/// JsonDatabase is a class that simulates a nonSQL database that stores
/// data in a JSON file.
/// This database allows you to create, read, update and delete data
/// collections.
///
/// Its guarantee of operation is an act of pure faith.
///
class JsonDatabaseService {
  late final File _file;

  JsonDatabaseService(String filename) {
    _file = File(filename);
    isOpen = false;
  }

  final math.Random _random = math.Random();

  Map<String, dynamic> _data = {};

  User? _loggedUser;

  User? get loggedUser => _loggedUser?.copyWith(password: '***');

  bool isOpen = false;

  /// Opens the database.
  ///
  /// If the file does not exist, it will be created and initialized with
  /// an empty JSON object.
  ///
  /// The database must be opened before any other operation.
  Future<void> open() async {
    if (isOpen) return;

    try {
      isOpen = true;
      if (await _file.exists()) {
        final content = await _file.readAsString();
        _data = json.decode(content) as Map<String, dynamic>;
      } else {
        await _file.create(recursive: true);
        await _file.writeAsString(json.encode({}));
        _data = <String, dynamic>{};
        _data[Collections.users.name] = <String, dynamic>{};
        final admin = User(
          id: _generateUid(),
          name: 'admin',
          password: '123qwe',
          addressId: '',
          document: '',
          contact: '',
          position: Positions.admin,
          createdAt: DateTime.now(),
        );
        _data[Collections.users.name][admin.id!] = admin.toMap();
        await _save();
      }
    } on Exception catch (err) {
      isOpen = false;
      throw Exception(err);
    }
  }

  /// Signs in the user.
  ///
  /// The user is identified by its 'username' and 'password'.
  ///
  /// The database must be opened before calling this function.
  ///
  /// If the user is found, the user is stored in [_loggedUser] and
  /// returned.
  ///
  /// If the user is not found or the password is invalid, null is returned.
  ///
  /// If an error occurs, null is returned.
  Future<User?> signIn(String userName, String password) async {
    if (!isOpen) await open();

    try {
      final findUser = _findUserByName(userName);

      if (findUser == null) {
        throw Exception('User not found');
      }

      if (findUser.password == null ||
          findUser.password!.toLowerCase() != password.toLowerCase()) {
        throw Exception('Invalid password');
      }

      _loggedUser = findUser;
      return _loggedUser!;
    } catch (err) {
      _loggedUser = null;
      log('JsonDatabaseService.signIn: $err');
      return null;
    }
  }

  /// Finds a user by its username.
  ///
  /// The user is identified by its 'username' key.
  ///
  /// Throws an exception if the user is not found.
  ///
  /// The database must be opened before calling this function.
  ///
  /// The user is stored in [_data] if the user is found.
  ///
  /// If an error occurs, null is returned.
  User? _findUserByName(String userName) {
    try {
      final users = _data[Collections.users.name] as Map<String, dynamic>?;
      if (users == null) {
        throw Exception('Users collection not found');
      }

      for (final userMap in users.values) {
        if ((userMap['name'] as String).toLowerCase() ==
            userName.toLowerCase()) {
          final findedUser = User.fromMap(userMap);
          return findedUser;
        }
      }
      return null;
    } catch (err) {
      log('JsonDatabaseService._findUser: $err');
      return null;
    }
  }

  /// Signs up a new user.
  ///
  /// The user is identified by its 'username', 'password', 'addressId',
  /// 'document', 'contact', and 'position' keys.
  ///
  /// Throws an exception if the user is not logged in or if the
  /// logged in user is not an admin or manager.
  ///
  /// Throws an exception if the user already exists.
  ///
  /// The database must be opened before calling this function.
  ///
  /// The user is stored in [_data] if the signup is successful.
  ///
  /// If an error occurs, false is returned.
  Future<String?> addUser(User user) async {
    if (!isOpen) await open();

    try {
      // Check if the user is logged in
      if (_loggedUser == null) {
        throw Exception('User not logged in');
      }

      // Only admin|manager users can create new users
      if (_loggedUser!.position != Positions.admin &&
          _loggedUser!.position != Positions.manager) {
        throw Exception('only admin or manager users can create new users.');
      }

      // Only admin users can create admin users.
      if (_loggedUser!.position != Positions.admin &&
          user.position == Positions.admin) {
        throw Exception('only admin users can create admin users.');
      }

      // Manager users can create only employee users
      if (_loggedUser!.position == Positions.manager &&
          user.position != Positions.employee) {
        throw Exception('manager users can create only employee users');
      }

      if (user.id != null) {
        throw Exception('User id is not null');
      }

      if (_findUserByName(user.name) != null) {
        throw Exception('User ${user.name} already exists');
      }

      final uid = _generateUid();
      final map = user.copyWith(id: uid).toMap();

      _data[Collections.users.name][uid] = map;
      await _save();

      return uid;
    } catch (err) {
      log('JsonDatabaseService.signUp: $err');
      return null;
    }
  }

  Future<bool> removeUser(String id) async {
    if (!isOpen) await open();

    try {
      // Check if the user is logged in
      if (_loggedUser == null) {
        throw Exception('User not logged in');
      }

      // Check for user in local database
      final userMap = _data[Collections.users.name][id];
      if (userMap == null) {
        throw Exception('Not found user of id $id.');
      }

      final position = Positions.values.byName(userMap['position'] as String);
      final loggedPosition = _loggedUser!.position;

      // Only admin|manager users can remove users
      if (loggedPosition != Positions.admin &&
          loggedPosition != Positions.manager) {
        throw Exception('only admin or manager users can create new users.');
      }

      // Only admin users can create admin users.
      if (loggedPosition != Positions.admin && position == Positions.admin) {
        throw Exception('only admin users can remove admin users.');
      }

      // Manager users can delete only employee users
      if (loggedPosition == Positions.manager &&
          position != Positions.employee) {
        throw Exception('manager users can create only employee users');
      }

      // Manager user can not remove admin user
      if (loggedPosition == Positions.manager && position == Positions.admin) {
        throw Exception('manager user can not remove admin user');
      }

      (_data[Collections.users.name] as Map<String, dynamic>).remove(id);
      await _save();

      return true;
    } catch (err) {
      log('JsonDatabaseService.removeUser: $err');
      return false;
    }
  }

  Future<bool> updateUser(User user) async {
    try {
      if (_loggedUser == null || user.name != _loggedUser!.name) {
        throw Exception('only owner can change your informations');
      }

      if (user.password == null) {
        throw Exception('a password is required to upgrade your information.');
      }

      if (Validate.password(user.password) != null) {
        throw Exception('this is a invalid password');
      }

      _data[Collections.users.name][user.id!] = user.toMap();
      _loggedUser = user;
      await _save();
      return true;
    } on Exception catch (err) {
      log('JsonDatabaseService.updateUser: $err');
      return false;
    }
  }

  /// Logs out the current user.
  ///
  /// Sets [_loggedUser] to null,
  /// and does not perform any other operation.
  ///
  /// The database must be opened before calling this function.
  ///
  /// If an error occurs, it is not thrown.
  Future<void> signOut() async {
    _loggedUser = null;
  }

  /// Closes the database.
  ///
  /// Saves any pending changes to the file, clears the in-memory data,
  /// and marks the database as closed.
  Future<void> close() async {
    if (!isOpen) return;
    try {
      // await _save();
      _data.clear();
      isOpen = false;
    } catch (err) {
      throw Exception(err);
    }
  }

  /// Creates a new collection in the database.
  ///
  /// If the collection already exists, throws an exception.
  ///
  /// The database must be opened before calling this function.
  ///
  /// The collection is created empty and is not populated with any data
  /// automatically.
  Future<void> createCollection(String collection) async {
    try {
      if (!isOpen) await open();

      if (_data.containsKey(collection)) {
        throw Exception('Collection already exists');
      }

      _data[collection] = <String, dynamic>{};
      await _save();
    } catch (err) {
      throw Exception(err);
    }
  }

  /// Deletes a collection from the database.
  ///
  /// If the collection does not exist, throws an exception.
  ///
  /// The database must be opened before calling this function.
  ///
  /// The collection and all its contents are deleted.
  ///
  Future<void> deleteCollection(Collections collection) async {
    try {
      if (!isOpen) await open();

      if (!_data.containsKey(collection.name)) {
        throw Exception('Collection $collection does not exist');
      }

      _data.remove(collection.name);
      await _save();
    } catch (err) {
      throw Exception(err);
    }
  }

  /// Inserts a new entry into the specified collection.
  ///
  /// The entry is a map of key-value pairs and must not contain a key
  /// named 'id'. A unique ID is generated and assigned automatically.
  ///
  /// Throws an exception if the collection does not exist or if the
  /// 'id' key in the map is not null.
  ///
  /// The database must be opened before calling this function.
  ///
  /// The entry is added to the collection and the database is saved
  /// immediately after insertion.
  Future<String> insertIntoCollection(
    Collections collection,
    Map<String, dynamic> map,
  ) async {
    try {
      if (!isOpen) await open();

      // Create the collection if it doesn't exist
      if (!_data.containsKey(collection.name)) {
        _data[collection.name] = <String, dynamic>{};
      }

      // Check if the 'id' key is null
      if (map['id'] != null) {
        throw Exception('"id" key is not null');
      }

      // Generate a unique ID
      final uid = _generateUid();
      map['id'] = uid;
      _data[collection.name] = {uid: map};

      await _save();
      return uid;
    } catch (err) {
      throw Exception(err);
    }
  }

  /// Removes an entry from the specified collection.
  ///
  /// The entry is identified by its 'id' key in the map.
  ///
  /// Throws an exception if the collection does not exist or if the
  /// 'id' key in the map does not exist in the collection.
  ///
  /// The database must be opened before calling this function.
  ///
  /// The entry is removed from the collection and the database is saved
  /// immediately after removal.
  Future<bool> removeFromCollection(Collections collection, String id) async {
    try {
      if (!isOpen) await open();

      if (!_data.containsKey(collection.name)) {
        throw Exception('Collection $collection does not exist');
      }

      if (!_data[collection.name].containsKey(id)) {
        throw Exception('Id $id does not exist');
      }

      _data[collection.name].remove(id);
      await _save();
      return true;
    } catch (err) {
      log('JsonDatabaseService.removeFromCollection: $err');
      return false;
    }
  }

  /// Updates an entry in the specified collection.
  ///
  /// The entry is identified by its 'id' key in the map.
  ///
  /// Throws an exception if the collection does not exist or if the
  /// 'id' key in the map does not exist in the collection.
  ///
  /// The database must be opened before calling this function.
  ///
  /// The entry is updated in the collection and the database is saved
  /// immediately after update.
  Future<bool> updateInCollection(
    Collections collection,
    Map<String, dynamic> map,
  ) async {
    try {
      if (!isOpen) await open();

      if (!_data.containsKey(collection.name)) {
        throw Exception('Collection ${collection.name} does not exist');
      }

      final id = map['id'];
      if (!_data[collection.name].containsKey(id)) {
        throw Exception('Id $id does not exist');
      }

      _data[collection.name][id] = map;
      await _save();
      return true;
    } catch (err) {
      log('JsonDatabaseService.updateInCollection: $err');
      return false;
    }
  }

  /// Retrieves an entry from the specified collection.
  ///
  /// The entry is identified by its 'id' key.
  ///
  /// Throws an exception if the collection does not exist or if the
  /// 'id' key does not exist in the collection.
  ///
  /// The database must be opened before calling this function.
  ///
  /// The entry is not modified and the database is not saved after
  /// retrieval.
  Future<Map<String, dynamic>?> getFromCollection(
    Collections collection,
    String id,
  ) async {
    try {
      if (!isOpen) await open();

      // Check if the collection exists
      if (!_data.containsKey(collection.name)) {
        throw Exception('Collection $collection does not exist');
      }

      // Check if the id exists in collection
      if (!_data[collection.name].containsKey(id)) {
        throw Exception('Id $id does not exist in collection $collection');
      }

      return _data[collection.name][id];
    } catch (err) {
      log('getFromCollection: $err');
      return null;
    }
  }

  /// Retrieves all entries from the specified collection.
  ///
  /// Returns a list of maps, where each map represents an entry in the
  /// collection.
  ///
  /// Throws an exception if the collection does not exist.
  ///
  /// The database must be opened before calling this function.
  Future<List<Map<String, dynamic>>> getAllFromCollection(
    Collections collection,
  ) async {
    try {
      if (!isOpen) await open();

      if (!_data.containsKey(collection.name)) {
        throw Exception('Collection ${collection.name} does not exist');
      }

      return _data[collection.name].values.toList();
    } catch (err) {
      throw Exception(err);
    }
  }

  /// Saves the current in-memory data to the file.
  ///
  /// Only performs the save operation if the database is open.
  /// The data is encoded as JSON and written to the associated file.
  Future<void> _save() async {
    if (!isOpen) return;
    await _file.writeAsString(json.encode(_data));
  }

  /// Generates a 12 character unique identifier.
  ///
  /// The identifier is a base-16 (hexadecimal) representation of 12 random
  /// numbers between 0 and 15. The identifier is not guaranteed to be unique, but
  /// the probability of collision is extremely low.
  String _generateUid() {
    return List.generate(
      32,
      (_) => _random.nextInt(16).toRadixString(16),
    ).join();
  }
}
