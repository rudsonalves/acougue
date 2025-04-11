import 'dart:developer';

import '/data/repositories/butcher_shop/butcher_shop_repository.dart';
import '../common/collections.dart';
import '/domain/models/butcher_shop.dart';
import '../../services/json_service.dart';
import '/utils/result.dart';

class LocalButcherShopRepository implements ButcherShopRepository {
  final JsonService _jsonServer;

  LocalButcherShopRepository(this._jsonServer) {
    get();
  }

  ButcherShop? _butcher;

  @override
  ButcherShop? get butcher => _butcher;

  static final butcherCollection = Collections.butcher.name;

  @override
  Future<Result<ButcherShop>> add(ButcherShop butcher) async {
    try {
      // Clean the collection. This collection is only used to store the
      // one butcher shop
      await _jsonServer.deleteCollection(butcherCollection);
      await _jsonServer.insertIntoCollection(
        butcherCollection,
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
      final result = await _jsonServer.getAllFromCollection(butcherCollection);

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
      await _jsonServer.removeFromCollection(butcherCollection, _butcher!.id!);

      _butcher = null;
      return const Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> update(ButcherShop butcher) async {
    try {
      await _jsonServer.updateInCollection(butcherCollection, butcher.toMap());
      _butcher = butcher;
      return const Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }
}
