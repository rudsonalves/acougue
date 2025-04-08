import 'dart:developer';

import '/data/repositories/butcher_shop/butcher_shop_repository.dart';
import '/data/repositories/common/app_constats.dart';
import '/domain/models/butcher_shop.dart';
import '../../services/json_database_service.dart';
import '/utils/result.dart';

class LocalButcherShopRepository implements ButcherShopRepository {
  final JsonDatabaseService _database;

  LocalButcherShopRepository(this._database);

  ButcherShop? _butcher;

  @override
  Future<Result<ButcherShop>> add(ButcherShop butcher) async {
    try {
      // Clean the collection. This collection is only used to store the
      // one butcher shop
      await _database.deleteCollection(Collections.butcherShop);
      await _database.insertIntoCollection(
        Collections.butcherShop,
        butcher.toMap(),
      );
      _butcher = butcher;
      return Result.success(_butcher!);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<ButcherShop>> get() async {
    try {
      final result = await _database.getAllFromCollection(
        Collections.butcherShop,
      );

      _butcher = ButcherShop.fromMap(result.first);
      return Result.success(_butcher!);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> delete() async {
    try {
      await _database.removeFromCollection(
        Collections.butcherShop,
        _butcher!.id!,
      );

      _butcher = null;
      return Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> update(ButcherShop butcher) async {
    try {
      await _database.updateInCollection(
        Collections.butcherShop,
        butcher.toMap(),
      );
      _butcher = butcher;
      return Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }
}
