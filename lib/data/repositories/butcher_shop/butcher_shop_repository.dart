import '/domain/models/butcher_shop.dart';
import '/utils/result.dart';

abstract class ButcherShopRepository {
  ButcherShop? get butcher;
  Future<Result<ButcherShop>> add(ButcherShop butcher);
  Future<Result<void>> update(ButcherShop butcher);
  Future<Result<void>> delete();
  Future<Result<ButcherShop>> get();
}
