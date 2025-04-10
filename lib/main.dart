import 'package:flutter/material.dart';

import '/main_app.dart';
import '/config/dependencies.dart';
import 'data/services/json_service.dart';
import '/utils/provider.dart';

Future<void> main() async {
  final jsonService = JsonService('storage/data.json');
  await jsonService.open();

  runApp(
    MultiProvider(providers: dependencies(jsonService), child: const MainApp()),
  );
}
