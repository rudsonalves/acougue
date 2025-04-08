import 'package:flutter/material.dart';

import '/ui/core/themes/dimens.dart';

class BasicTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final FloatingLabelBehavior floatingLabelBehavior;
  final InputBorder? border;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  const BasicTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.border,
    this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.onChanged,
    this.focusNode,
    this.onEditingComplete,
    this.validator,
  });

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  AutovalidateMode? autoValidate;

  @override
  void initState() {
    widget.controller?.addListener(_checkValidation);
    super.initState();
  }

  void _checkValidation() {
    if (autoValidate != null || widget.controller!.text.isEmpty) return;

    setState(() {
      autoValidate = AutovalidateMode.always;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Dimens dimens = Dimens.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      autovalidateMode: autoValidate,
      controller: widget.controller,
      focusNode: widget.focusNode,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        floatingLabelBehavior: widget.floatingLabelBehavior,
        border:
            widget.border ??
            OutlineInputBorder(
              borderRadius: dimens.borderRadius,
              borderSide: BorderSide(color: colorScheme.onPrimary),
            ),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
      ),
    );
  }
}
