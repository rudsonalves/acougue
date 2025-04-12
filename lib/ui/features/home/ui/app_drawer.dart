import 'package:flutter/material.dart';

import '/ui/core/ui/images/logo_image.dart';

class AppDrawer extends StatelessWidget {
  final void Function() goToRegistrationsPage;
  final void Function() goToProductsInput;
  final void Function() goToEmployees;

  const AppDrawer({
    super.key,
    required this.goToRegistrationsPage,
    required this.goToProductsInput,
    required this.goToEmployees,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            // decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              children: [LogoImage(radius: 50), Text('Sabor da Morte')],
            ),
          ),
          ListTile(
            title: const Text('Registros'),
            leading: const Icon(Icons.list),
            onTap: () {
              Navigator.pop(context);
              goToRegistrationsPage();
            },
          ),
          ListTile(
            title: const Text('Adicionar Produto'),
            leading: const Icon(Icons.add),
            onTap: () {
              Navigator.pop(context);
              goToProductsInput();
            },
          ),
          ListTile(
            title: const Text('Empregados'),
            leading: const Icon(Icons.people),
            onTap: () {
              Navigator.pop(context);
              goToEmployees();
            },
          ),
        ],
      ),
    );
  }
}
