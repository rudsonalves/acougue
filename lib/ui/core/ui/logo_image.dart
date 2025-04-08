import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  final double radius;
  const LogoImage({super.key, required this.radius});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CircleAvatar(
      radius: radius,
      backgroundColor: colorScheme.onPrimaryContainer,
      child: Image.asset(
        'assets/images/logo.png',
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
