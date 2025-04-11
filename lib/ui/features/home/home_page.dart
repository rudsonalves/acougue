import 'package:flutter/material.dart';

import 'package:acougue/routing/router.dart';
import '/ui/core/themes/dimens.dart';
import '/ui/core/themes/brightness_controller.dart';
import '/ui/features/home/home_view_model.dart';
import '/utils/provider.dart';

class HomePage extends StatefulWidget {
  final HomeViewModel homeViewModel;

  const HomePage({super.key, required this.homeViewModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final brightness = NotifierProvider.of<BrightnessController>(context);
    // final colorScheme = Theme.of(context).colorScheme;
    final dimens = Dimens.of(context);

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
                  brightness.isDark ? Icons.dark_mode : Icons.light_mode,
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(dimens.paddingScreenAll),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: dimens.spacingVertical,
          children: [
            OverflowBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                FilledButton(
                  onPressed: _goToRegistrationsPage,
                  child: const Text('Registros'),
                ),
                FilledButton(
                  onPressed: _goToProductsInput,
                  child: const Text('Adicionar Produto'),
                ),
                const FilledButton(
                  onPressed: null,
                  child: Text('Cadastrar Pessoas'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _goToRegistrationsPage() {
    Navigator.pushNamed(context, Routes.registrations);
  }

  void _goToProductsInput() {
    Navigator.pushNamed(context, Routes.editProduct);
  }
}
