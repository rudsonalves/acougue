import 'package:acougue/routing/router.dart';
import 'package:acougue/ui/core/themes/brightness_controller.dart';
import 'package:acougue/ui/core/themes/theme.dart';
import 'package:acougue/data/services/json_database.dart';
import 'package:acougue/utils/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        (child) => NotifierProvider<BrightnessController>(
          value: BrightnessController(),
          child: child,
        ),
        (child) => SimpleProvider(
          value: JsonDatabaseService('data.json'),
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
