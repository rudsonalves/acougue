import 'package:acougue/routing/router.dart';
import 'package:flutter/material.dart';

class RegistrationsPage extends StatefulWidget {
  const RegistrationsPage({super.key});

  @override
  State<RegistrationsPage> createState() => _RegistrationsPageState();
}

class _RegistrationsPageState extends State<RegistrationsPage> {
  @override
  Widget build(BuildContext context) {
    // final dimens = Dimens.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros'),
        centerTitle: true,
        elevation: 5,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton.icon(
                onPressed: _goToButcheRegistration,
                label: const Text('Registro do Açougue'),
              ),
              FilledButton.icon(
                onPressed: () {},
                label: const Text('Registro dos Freezers'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton.icon(
                onPressed: () {},
                label: const Text('Registro dos Funcionários'),
              ),
              FilledButton.icon(
                onPressed: () {},
                label: const Text('Registro das Validades'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _goToButcheRegistration() {
    Navigator.pushNamed(context, Routes.butcherShop);
  }
}
