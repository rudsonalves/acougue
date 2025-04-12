import 'package:flutter/material.dart';

class ButtonsHeader extends StatelessWidget {
  final void Function() goToRegistrationsPage;
  final void Function() goToEmployees;

  const ButtonsHeader({
    super.key,
    required this.goToRegistrationsPage,
    required this.goToEmployees,
  });

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      alignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          onPressed: goToRegistrationsPage,
          icon: const Icon(Icons.list),
          label: const Text('Registros'),
        ),
        ElevatedButton.icon(
          onPressed: goToEmployees,
          icon: const Icon(Icons.people),
          label: const Text('Empregados'),
        ),
      ],
    );
  }
}
