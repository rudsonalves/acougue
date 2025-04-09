import 'package:acougue/ui/core/themes/dimens.dart';
import 'package:flutter/material.dart';

class BasicDropdownField<T> extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final InputBorder? border;
  final Widget? prefixIcon;

  const BasicDropdownField({
    super.key,
    this.labelText,
    this.hintText,
    required this.value,
    required this.items,
    required this.itemLabel,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.onChanged,
    this.validator,
    this.border,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final Dimens dimens = Dimens.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return DropdownButtonFormField<T>(
      value: value,
      alignment: Alignment.center,
      isExpanded: true,
      items:
          items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabel(item)),
            );
          }).toList(),
      decoration: InputDecoration(
        floatingLabelBehavior: floatingLabelBehavior,
        prefixIcon: prefixIcon,
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(
          color: colorScheme.secondary.withValues(alpha: 0.6),
        ),
        border:
            border ??
            OutlineInputBorder(
              borderRadius: dimens.borderRadius,
              borderSide: BorderSide(color: colorScheme.onPrimary),
            ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
