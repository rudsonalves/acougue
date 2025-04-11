import 'package:flutter/material.dart';

import '/data/repositories/products/local_products_repository.dart';
import '/ui/features/home/edit_product/edit_product_page.dart';
import '/ui/features/home/edit_product/product_view_model.dart';
import '/data/repositories/freezers/local_freezers_repository.dart';
import '/ui/features/home/registrations/freezers/edit_freezer/edit_freezer_page.dart';
import '/ui/features/home/registrations/freezers/freezers_page.dart';
import '/ui/features/home/registrations/freezers/view_models/edit_freezer_view_model.dart';
import '/data/repositories/butcher_shop/local_butcher_shop_repository.dart';
import '/ui/features/home/home_view_model.dart';
import '/ui/features/home/registrations/butcher_shop/butcher_shop_page.dart';
import '/ui/features/home/registrations/view_model/butcher_shop_view_model.dart';
import '/ui/features/home/registrations/registrations_page.dart';
import '/data/repositories/addresses/local_address_repository.dart';
import '/data/repositories/auth/local_auth_repository.dart';
import '/domain/models/address.dart';
import '/ui/features/address/address_page.dart';
import '/ui/features/address/address_view_model.dart';
import '/ui/features/edit_user/edit_user_page.dart';
import '/ui/features/edit_user/edit_view_model.dart';
import '/ui/features/sign_in/sign_in_view_model.dart';
import '/ui/features/splash/splash_page.dart';
import '/ui/features/splash/splash_view_model.dart';
import '/utils/provider.dart';
import '/ui/features/home/home_page.dart';
import '/ui/features/sign_in/sign_in.dart';

final class Routes {
  Routes._();

  static const String initialRoute = splash;

  static const String home = '/';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String splash = '/splash';
  static const String editUser = '/edit-user';
  static const String address = '/address';
  static const String registrations = '/registration';
  static const String butcherShop = '/butcher-shop';
  static const String freezers = '/freezers';
  static const String editFreezer = '/edit-freezer';
  static const String editProduct = '/edit-products';

  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.home:
        (context) => HomePage(
          homeViewModel: HomeViewModel(
            freezersRepository: SimpleProvider.of<LocalFreezersRepository>(
              context,
            ),
            productsRepository: SimpleProvider.of<LocalProductsRepository>(
              context,
            ),
            authRepository: SimpleProvider.of<LocalAuthRepository>(context),
          ),
        ),
    Routes.signin:
        (context) => SignInPage(
          signInViewModel: SignInViewModel(
            SimpleProvider.of<LocalAuthRepository>(context),
          ),
        ),

    Routes.splash:
        (context) => SplashPage(
          splashViewModel: SplashViewModel(
            SimpleProvider.of<LocalAuthRepository>(context),
          ),
        ),
    Routes.editUser:
        (context) => EditUserPage(
          editViewModel: EditViewModel(
            authRepository: SimpleProvider.of<LocalAuthRepository>(context),
            addressRepository: SimpleProvider.of<LocalAddressRepository>(
              context,
            ),
          ),
        ),
    Routes.registrations:
        (context) => RegistrationsPage(
          butcherShopViewModel: ButcherShopViewModel(
            addressRepository: SimpleProvider.of<LocalAddressRepository>(
              context,
            ),
            butcherShopRepository:
                SimpleProvider.of<LocalButcherShopRepository>(context),
          ),
          freezersViewModel: FreezersViewModel(
            SimpleProvider.of<LocalFreezersRepository>(context),
          ),
        ),
    Routes.butcherShop:
        (context) => ButcherShopPage(
          butcherShopViewModel: ButcherShopViewModel(
            addressRepository: SimpleProvider.of<LocalAddressRepository>(
              context,
            ),
            butcherShopRepository:
                SimpleProvider.of<LocalButcherShopRepository>(context),
          ),
        ),
    Routes.freezers:
        (context) => FreezersPage(
          freezersViewModel: FreezersViewModel(
            SimpleProvider.of<LocalFreezersRepository>(context),
          ),
        ),
  };

  static Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case Routes.address:
        final callBack = arguments!['callBack'] as Function(Address);
        final adressId = arguments['addressId'] as String?;
        return MaterialPageRoute(
          builder:
              (context) => AddressPage(
                callBack: callBack,
                addressId: adressId,
                addressViewModel: AddressViewModel(
                  SimpleProvider.of<LocalAddressRepository>(context),
                ),
              ),
        );
      case Routes.editFreezer:
        final freezerId = arguments?['freezerId'] as String?;
        return MaterialPageRoute(
          builder:
              (context) => EditFreezerPage(
                freezerId: freezerId,
                freezersViewModel: FreezersViewModel(
                  SimpleProvider.of<LocalFreezersRepository>(context),
                ),
              ),
        );
      case Routes.editProduct:
        final productId = arguments?['productId'] as String?;
        return MaterialPageRoute(
          builder:
              (context) => EditProductPage(
                productId: productId,
                productsViewModel: ProductViewModel(
                  freezersRepository:
                      SimpleProvider.of<LocalFreezersRepository>(context),
                  productsRepository:
                      SimpleProvider.of<LocalProductsRepository>(context),
                  authRepository: SimpleProvider.of<LocalAuthRepository>(
                    context,
                  ),
                ),
              ),
        );
      default:
        return null;
    }
  }
}
