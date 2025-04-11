import 'package:acougue/domain/models/product.dart';
import 'package:acougue/utils/result.dart';

abstract class ProductsRepository {
  Map<String, Product> get products;
  List<Product> get productsList;
  Product? getProduct(String id);

  Future<Result<Product>> add(Product freezer);
  Future<Result<Product>> get(String id);
  Future<Result<void>> getAll();
  Future<Result<Product>> update(Product freezer);
  Future<Result<void>> delete(String id);

  List<Product> sortByExpirationDate([bool asc = true]);
}
