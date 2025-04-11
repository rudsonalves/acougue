import '/data/repositories/common/collections.dart';
import '/data/repositories/products/products_repository.dart';
import '/data/services/json_service.dart';
import '/domain/models/product.dart';
import '/utils/logger.dart';
import '/utils/result.dart';

class LocalProductsRepository implements ProductsRepository {
  final JsonService _jsonServer;

  LocalProductsRepository(this._jsonServer) {
    _initialize();
  }

  final Map<String, Product> _products = {};

  static final freezerCollection = Collections.products.name;

  final logger = Logger('LocalProductsRepository');

  @override
  Product? getProduct(String id) => _products[id];

  @override
  Map<String, Product> get products => _products;

  @override
  List<Product> get productsList => _products.values.toList();

  Future<void> _initialize() async {
    await getAll();
  }

  @override
  Future<Result<Product>> add(Product freezer) async {
    try {
      final uid = await _jsonServer.insertIntoCollection(
        freezerCollection,
        freezer.toMap(),
      );

      final newProduct = freezer.copyWith(id: uid);
      _products[uid] = newProduct;
      return Result.success(newProduct);
    } on Exception catch (err) {
      logger.critical('add', err);
      return Result.failure(err);
    }
  }

  @override
  Future<Result<Product>> get(String id) async {
    try {
      final map = await _jsonServer.getFromCollection(freezerCollection, id);

      if (map == null) {
        return Result.failure(Exception('Product not found'));
      }

      final product = Product.fromMap(map);
      return Result.success(product);
    } on Exception catch (err) {
      logger.critical('get', err);
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> getAll() async {
    try {
      final listMap = await _jsonServer.getAllFromCollection(freezerCollection);

      _products.clear();
      if (listMap.isEmpty) {
        return const Result.success(null);
      }

      _products.addEntries(
        listMap.map((map) => MapEntry(map['id'], Product.fromMap(map))),
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
      await _jsonServer.removeFromCollection(freezerCollection, id);

      _products.remove(id);
      return const Result.success(null);
    } on Exception catch (err) {
      logger.critical('get', err);
      return Result.failure(err);
    }
  }

  @override
  Future<Result<Product>> update(Product product) async {
    try {
      await _jsonServer.updateInCollection(freezerCollection, product.toMap());

      _products[product.id!] = product;
      return Result.success(product);
    } on Exception catch (err) {
      logger.critical('add', err);
      return Result.failure(err);
    }
  }

  @override
  List<Product> sortByExpirationDate([bool asc = true]) {
    final products = productsList;

    if (asc) {
      products.sort((a, b) => a.expirationDate.compareTo(b.expirationDate));
    } else {
      products.sort((a, b) => b.expirationDate.compareTo(a.expirationDate));
    }

    return products;
  }
}
