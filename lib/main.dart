import 'package:flutter/material.dart';

import '/data/repositories/auth/local_auth_repository.dart';
import '/routing/router.dart';
import '/ui/core/themes/brightness_controller.dart';
import '/ui/core/themes/theme.dart';
import 'data/services/json_service.dart';
import '/utils/provider.dart';

void main() {
  final jsonService = JsonService('storage/data.json');

  runApp(
    MultiProvider(
      providers: [
        (child) => NotifierProvider<BrightnessController>(
          value: BrightnessController(),
          child: child,
        ),
        (child) => SimpleProvider(
          value: LocalAuthRepository(jsonService),
          child: child,
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late MaterialTheme theme;

  @override
  void initState() {
    theme = MaterialTheme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = NotifierProvider.of<BrightnessController>(context);

    return ListenableBuilder(
      listenable: brightness,
      builder: (context, _) {
        return MaterialApp(
          theme: brightness.isDark ? theme.dark() : theme.light(),
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.initialRoute,
          routes: Routes.routes,
          // onGenerateInitialRoutes: Routes.onGenerateInitialRoutes,
        );
      },
    );
  }
}
