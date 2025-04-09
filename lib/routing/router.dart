import 'package:acougue/data/repositories/addresses/local_address_repository.dart';
import 'package:acougue/data/repositories/auth/local_auth_repository.dart';
import 'package:acougue/ui/features/address/address_page.dart';
import 'package:acougue/ui/features/address/address_view_model.dart';
import 'package:acougue/ui/features/edit_user/edit_user_page.dart';
import 'package:acougue/ui/features/edit_user/edit_view_model.dart';
import 'package:acougue/ui/features/sign_in/sign_in_view_model.dart';
import 'package:acougue/ui/features/sign_up/sign_up_view_model.dart';
import 'package:acougue/ui/features/splash/splash_page.dart';
import 'package:acougue/ui/features/splash/splash_view_model.dart';
import 'package:acougue/utils/provider.dart';
import 'package:flutter/material.dart';

import '/ui/features/home/home_page.dart';
import '/ui/features/sign_in/sign_in.dart';
import '/ui/features/sign_up/sign_up_page.dart';

final class Routes {
  Routes._();

  static const String initialRoute = splash;

  static const String home = '/';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String splash = '/splash';
  static const String editUser = '/edit-user';
  static const String address = '/address';

  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.home: (context) => const HomePage(),
    Routes.signin:
        (context) => SignInPage(
          signInViewModel: SignInViewModel(
            SimpleProvider.of<LocalAuthRepository>(context),
          ),
        ),
    Routes.signup:
        (context) => SignUpPage(
          signUpViewModel: SignUpViewModel(
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
            SimpleProvider.of<LocalAuthRepository>(context),
          ),
        ),
    Routes.address:
        (context) => AddressPage(
          addressViewModel: AddressViewModel(
            SimpleProvider.of<LocalAddressRepository>(context),
          ),
        ),
  };

  static List<Route<dynamic>>? onGenerateInitialRoutes(String routeName) {
    return null;
  }
}
