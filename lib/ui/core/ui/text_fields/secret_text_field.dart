import 'package:flutter/material.dart';

import 'basic_text_field.dart';

class SecretTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final FloatingLabelBehavior floatingLabelBehavior;
  final InputBorder? border;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  const SecretTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.border,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.prefixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.focusNode,
    this.validator,
  });

  @override
  State<SecretTextField> createState() => _SecretTextFieldState();
}

class _SecretTextFieldState extends State<SecretTextField> {
  bool _isObscured = true;

  _toggleObscured() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BasicTextField(
      labelText: widget.labelText,
      hintText: widget.hintText,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      keyboardType: TextInputType.text,
      obscureText: _isObscured,
      focusNode: widget.focusNode,
      prefixIcon: widget.prefixIcon,
      validator: widget.validator,
      suffixIcon: IconButton(
        onPressed: _toggleObscured,
        icon: Icon(
          _isObscured ? Icons.visibility_off_rounded : Icons.visibility_rounded,
          color: colorScheme.primary,
        ),
      ),
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
    );
  }
}
