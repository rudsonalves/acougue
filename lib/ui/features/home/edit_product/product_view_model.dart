import 'package:acougue/data/repositories/auth/auth_repository.dart';
import 'package:acougue/domain/models/user.dart';

import '/data/repositories/freezers/freezers_repository.dart';
import '/data/repositories/products/products_repository.dart';
import '/domain/models/freezer.dart';
import '/domain/models/product.dart';
import '/utils/commands.dart';
import '/utils/logger.dart';
import '/utils/result.dart';

class ProductViewModel {
  final ProductsRepository _productsRepository;
  final FreezersRepository _freezersRepository;
  final AuthRepository _authRepository;

  ProductViewModel({
    required ProductsRepository productsRepository,
    required FreezersRepository freezersRepository,
    required AuthRepository authRepository,
  }) : _productsRepository = productsRepository,
       _freezersRepository = freezersRepository,
       _authRepository = authRepository {
    save = Command1<Product, Product>(_save);
    update = Command1<void, Product>(_update);
    getProduct = Command1<Product, String>(_getProduct);
  }

  late final Command1<Product, Product> save;
  late final Command1<void, Product> update;
  late final Command1<Product, String> getProduct;

  List<Freezer> get freezersList => _freezersRepository.freezersList;
  User get user => _authRepository.user!;

  final logger = Logger('ProductViewModel');

  Future<Result<Product>> _save(Product product) async {
    final result = await _productsRepository.add(product);

    await Future.delayed(const Duration(seconds: 1));

    result.fold(
      onSuccess: (product) {
        logger.info('_save', 'Product created.');
      },
      onFailure: (err) {
        logger.warning('_save', err);
      },
    );

    return result;
  }

  Future<Result<void>> _update(Product product) async {
    final result = await _productsRepository.update(product);

    await Future.delayed(const Duration(seconds: 1));

    result.fold(
      onSuccess: (_) {
        logger.info('_update', 'Address updated');
      },
      onFailure: (err) {
        logger.warning('_update', 'Error: $err');
      },
    );

    return result;
  }

  Future<Result<Product>> _getProduct(String? id) async {
    if (id == null) return Result.failure(Exception('Product id is null'));

    final result = await _productsRepository.get(id);

    result.fold(
      onSuccess: (product) {
        logger.info('_getProduct', 'Get product ${product.id}');
      },
      onFailure: (err) {
        logger.warning('_getProduct', 'Product not found: $err');
      },
    );

    return result;
  }
}
