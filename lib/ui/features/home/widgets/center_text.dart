import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  final String text;
  final Color? color;

  const CenterText({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}
