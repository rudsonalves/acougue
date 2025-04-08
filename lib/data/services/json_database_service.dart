import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:developer';

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
  late final Map<String, dynamic> _data;

  JsonDatabaseService(String filename) {
    _file = File(filename);
    isOpen = false;
  }

  bool isOpen = false;
  final math.Random _random = math.Random();

  /// Opens the database.
  ///
  /// If the file does not exist, it will be created and initialized with
  /// an empty JSON object.
  ///
  /// The database must be opened before any other operation.
  Future<void> open() async {
    if (isOpen) return;

    try {
      if (await _file.exists()) {
        final content = await _file.readAsString();
        _data = json.decode(content) as Map<String, dynamic>;
      } else {
        await _file.create(recursive: true);
        await _file.writeAsString(json.encode({}));
        _data = <String, dynamic>{};
      }
      isOpen = true;
    } catch (err) {
      throw Exception(err);
    }
  }

  /// Closes the database.
  ///
  /// Saves any pending changes to the file, clears the in-memory data,
  /// and marks the database as closed.
  Future<void> close() async {
    if (!isOpen) return;
    try {
      await _save();
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
  Future<void> deleteCollection(String collection) async {
    try {
      if (!isOpen) await open();

      if (!_data.containsKey(collection)) {
        throw Exception('Collection $collection does not exist');
      }

      _data.remove(collection);
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
    String collection,
    Map<String, dynamic> map,
  ) async {
    try {
      if (!isOpen) await open();

      if (!_data.containsKey(collection)) {
        throw Exception('Collection $collection does not exist');
      }

      if (map['id'] != null) {
        throw Exception('"id" key is not null');
      }

      map.remove('id');
      String uid = _generateUid();
      _data[collection] = {uid: map};

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
  Future<void> removeFromCollection(String collection, String id) async {
    try {
      if (!isOpen) await open();

      if (!_data.containsKey(collection)) {
        throw Exception('Collection $collection does not exist');
      }

      if (!_data.containsKey(id)) {
        throw Exception('Id $id does not exist');
      }

      _data[collection].remove(id);
      await _save();
    } catch (err) {
      throw Exception(err);
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
  Future<void> updateInCollection(
    String collection,
    Map<String, dynamic> map,
  ) async {
    try {
      if (!isOpen) await open();

      if (!_data.containsKey(collection)) {
        throw Exception('Collection $collection does not exist');
      }

      final id = map['id'];
      if (!_data.containsKey(id)) {
        throw Exception('Id $id does not exist');
      }

      map.remove('id');

      _data[collection][id] = map;
      await _save();
    } catch (err) {
      throw Exception(err);
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
    String collection,
    String id,
  ) async {
    try {
      if (!isOpen) await open();

      if (!_data.containsKey(collection)) {
        throw Exception('Collection $collection does not exist');
      }

      if (!_data.containsKey(id)) {
        throw Exception('Id $id does not exist');
      }

      return _data[collection][id];
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
    String collection,
  ) async {
    try {
      if (!isOpen) await open();

      if (!_data.containsKey(collection)) {
        throw Exception('Collection $collection does not exist');
      }

      return _data[collection].values.toList();
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
      12,
      (_) => _random.nextInt(16).toRadixString(16),
    ).join();
  }
}
