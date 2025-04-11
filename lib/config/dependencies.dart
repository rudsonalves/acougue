import 'package:flutter/material.dart';

import '/data/repositories/products/local_products_repository.dart';
import '/data/repositories/freezers/local_freezers_repository.dart';
import '/data/repositories/addresses/local_address_repository.dart';
import '/data/repositories/auth/local_auth_repository.dart';
import '/data/repositories/butcher_shop/local_butcher_shop_repository.dart';
import '/data/services/json_service.dart';
import '/ui/core/themes/brightness_controller.dart';
import '/utils/provider.dart';

List<Widget Function(Widget)> dependencies(JsonService jsonService) {
  return [
    (child) => NotifierProvider<BrightnessController>(
      value: BrightnessController(),
      child: child,
    ),
    (child) => SimpleProvider<LocalAuthRepository>(
      value: LocalAuthRepository(jsonService),
      child: child,
    ),
    (child) => SimpleProvider<LocalAddressRepository>(
      value: LocalAddressRepository(jsonService),
      child: child,
    ),
    (child) => SimpleProvider<LocalButcherShopRepository>(
      value: LocalButcherShopRepository(jsonService),
      child: child,
    ),
    (child) => SimpleProvider<LocalFreezersRepository>(
      value: LocalFreezersRepository(jsonService),
      child: child,
    ),
    (child) => SimpleProvider<LocalProductsRepository>(
      value: LocalProductsRepository(jsonService),
      child: child,
    ),
  ];
}
