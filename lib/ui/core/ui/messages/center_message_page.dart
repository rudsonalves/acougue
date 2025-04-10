import 'package:acougue/ui/core/themes/dimens.dart';
import 'package:flutter/material.dart';

class CenterMessagePage extends StatelessWidget {
  final IconData iconData;
  final String message;

  const CenterMessagePage({
    super.key,
    required this.iconData,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dimens = Dimens.of(context);

    return Center(
      child: Card(
        color: colorScheme.primaryContainer.withValues(alpha: .45),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.paddingAll),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: dimens.spacingVertical,
            children: [
              Icon(iconData, size: 45),
              Text(message, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
