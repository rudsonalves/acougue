import 'package:flutter/material.dart';

class HomeHeaderRow extends StatelessWidget {
  final void Function() callBack;

  const HomeHeaderRow({super.key, required this.callBack});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [const SizedBox(width: 18), labelText('Produtos')],
            ),
          ),
          Expanded(child: labelText('Entrada')),
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(5),
              color: colorScheme.surfaceContainerHighest,
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: callBack,
                child: labelText('Validade'),
              ),
            ),
          ),
          Expanded(child: labelText('Usuário')),
          Expanded(child: labelText('Localização')),
        ],
      ),
    );
  }

  Widget labelText(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
