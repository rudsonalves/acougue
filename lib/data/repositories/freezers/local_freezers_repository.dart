import '/utils/logger.dart';
import '/data/repositories/common/collections.dart';
import '/data/repositories/freezers/freezers_repository.dart';
import '/data/services/json_service.dart';
import '/domain/models/freezer.dart';
import '/utils/result.dart';

class LocalFreezersRepository implements FreezersRepository {
  final JsonService _jsonServer;

  LocalFreezersRepository(this._jsonServer) {
    _initialize();
  }

  final Map<String, Freezer> _freezers = {};

  static const freezerCollection = Collections.freezers;

  final logger = Logger('LocalFreezersRepository');

  @override
  Freezer? getFreezer(String id) => _freezers[id];

  @override
  Map<String, Freezer> get freezers => _freezers;

  @override
  List<Freezer> get freezersList => _freezers.values.toList();

  Future<void> _initialize() async {
    await getAll();
  }

  @override
  Future<Result<Freezer>> add(Freezer freezer) async {
    try {
      final uid = await _jsonServer.insertIntoCollection(
        freezerCollection.name,
        freezer.toMap(),
      );

      final newFreezer = freezer.copyWith(id: uid);
      _freezers[uid] = newFreezer;
      return Result.success(newFreezer);
    } on Exception catch (err) {
      logger.critical('add', err);
      return Result.failure(err);
    }
  }

  @override
  Future<Result<Freezer>> get(String id) async {
    try {
      final map = await _jsonServer.getFromCollection(
        freezerCollection.name,
        id,
      );

      if (map == null) {
        return Result.failure(Exception('Freezer not found'));
      }

      final freezer = Freezer.fromMap(map);
      return Result.success(freezer);
    } on Exception catch (err) {
      logger.critical('get', err);
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> getAll() async {
    try {
      final listMap = await _jsonServer.getAllFromCollection(freezerCollection);

      _freezers.clear();
      if (listMap.isEmpty) {
        return const Result.success(null);
      }

      _freezers.addEntries(
        listMap.map((map) => MapEntry(map['id'], Freezer.fromMap(map))),
      );

      return const Result.success(null);
    } on Exception catch (err) {
      logger.critical('getAll', err);
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await _jsonServer.removeFromCollection(freezerCollection.name, id);

      return const Result.success(null);
    } on Exception catch (err) {
      logger.critical('get', err);
      return Result.failure(err);
    }
  }

  @override
  Future<Result<Freezer>> update(Freezer freezer) async {
    try {
      await _jsonServer.updateInCollection(
        freezerCollection.name,
        freezer.toMap(),
      );

      return Result.success(freezer);
    } on Exception catch (err) {
      logger.critical('add', err);
      return Result.failure(err);
    }
  }
}
