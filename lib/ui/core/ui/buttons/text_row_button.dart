import 'package:flutter/material.dart';

class TextRowButton extends StatelessWidget {
  final String labelText;
  final String textButton;
  final void Function()? onPressed;

  const TextRowButton({
    super.key,
    required this.labelText,
    required this.textButton,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(labelText),
        TextButton(
          onPressed: onPressed,
          child: Text(
            textButton,
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
