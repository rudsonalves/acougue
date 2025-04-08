import 'package:acougue/ui/features/home/home_page.dart';
import 'package:acougue/ui/features/sign_in/sign_in.dart';
import 'package:acougue/ui/features/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';

final class Routes {
  Routes._();

  static const String initialRoute = home;

  static const String home = '/';
  static const String signin = '/signin';
  static const String signup = '/signup';

  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.home: (context) => const HomePage(),
    Routes.signin: (context) => const SignInPage(),
    Routes.signup: (context) => const SignUpPage(),
  };

  static List<Route<dynamic>>? onGenerateInitialRoutes(String routeName) {
    return null;
  }
}
