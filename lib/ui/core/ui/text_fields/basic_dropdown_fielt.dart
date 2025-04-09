import 'package:acougue/ui/core/themes/dimens.dart';
import 'package:flutter/material.dart';

class BasicDropdownField<T> extends StatelessWidget {
  final String? labelText;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final InputBorder? border;
  final Widget? prefixIcon;

  const BasicDropdownField({
    super.key,
    this.labelText,
    required this.value,
    required this.items,
    required this.itemLabel,
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
        prefixIcon: prefixIcon,
        labelText: labelText,
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
