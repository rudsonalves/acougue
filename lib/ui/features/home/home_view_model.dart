import 'package:flutter/material.dart';

import '/domain/dto/user_info.dart';
import '/data/repositories/auth/auth_repository.dart';
import '/data/repositories/freezers/freezers_repository.dart';
import '/data/repositories/products/products_repository.dart';
import '/domain/models/freezer.dart';
import '/domain/models/product.dart';
import '/domain/models/user.dart';
import '/utils/logger.dart';

class HomeViewModel extends ChangeNotifier {
  final ProductsRepository _productsRepository;
  final FreezersRepository _freezersRepository;
  final AuthRepository _authRepository;

  HomeViewModel({
    required ProductsRepository productsRepository,
    required FreezersRepository freezersRepository,
    required AuthRepository authRepository,
  }) : _productsRepository = productsRepository,
       _freezersRepository = freezersRepository,
       _authRepository = authRepository;

  List<Freezer> get freezersList => _freezersRepository.freezersList;
  List<Product> get productList => _productsRepository.productsList;

  User get user => _authRepository.user!;
  UserInfo? getUserInfo(String id) => _authRepository.getUserInfo(id);
  Freezer? getFreezer(String id) => _freezersRepository.getFreezer(id);
  List<Product> sortByExpirationDate([bool asc = true]) =>
      _productsRepository.sortByExpirationDate(asc);

  final logger = Logger('HomeViewModel');
}
