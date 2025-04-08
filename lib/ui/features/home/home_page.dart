import 'package:acougue/routing/router.dart';
import 'package:acougue/ui/core/themes/brightness_controller.dart';
import 'package:acougue/utils/provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = NotifierProvider.of<BrightnessController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        elevation: 5,
        actions: [
          IconButton(
            onPressed: brightness.toggle,
            icon: ListenableBuilder(
              listenable: brightness,
              builder: (context, _) {
                return Icon(
                  brightness.isDark ? Icons.light_mode : Icons.dark_mode,
                );
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.signin);
          },
          child: const Text('Ir para Login'),
        ),
      ),
    );
  }
}
