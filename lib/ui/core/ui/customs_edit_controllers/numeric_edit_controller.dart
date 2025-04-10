import 'package:flutter/material.dart';

class NumericEditController<T extends num> extends TextEditingController {
  late final RegExp reInitZeroNumber;
  String oldValue = '';

  T get numericValue {
    if (T == int) return int.tryParse(text) as T? ?? 0 as T;
    if (T == double) return double.tryParse(text) as T? ?? 0 as T;
    throw UnsupportedError('Unsupported type: $T');
  }

  set numericValue(T value) {
    text = value.toString();
    oldValue = value.toString();
    _setControllerText();
  }

  bool _isValidateValue = false;

  NumericEditController({T? initialValue}) {
    oldValue = initialValue != null ? initialValue.toString() : '0';
    text = oldValue;
    if (T == int) {
      reInitZeroNumber = RegExp(r'^0[\d]*$');
    } else {
      reInitZeroNumber = RegExp(r'^0[\d][\.\d]*$');
    }
    addListener(_validateNumber);
  }

  void _validateNumber() {
    if (_isValidateValue) return;
    _isValidateValue = true;

    String newValue = text;

    // Remove point if T is int
    if (T == int && newValue.contains('.')) {
      oldValue = newValue.replaceAll('.', '');
      _setControllerText();
      _isValidateValue = false;
      return;
    }

    // Remove spaces
    if (newValue != newValue.trim()) {
      _setControllerText();
      _isValidateValue = false;
      return;
    }

    // Replase empty string by '0'
    if (newValue.isEmpty) {
      oldValue = '0';
      _setControllerText();
      _isValidateValue = false;
      return;
    }

    // Remove zeros from the start of the number ('02' -> '2')
    if (reInitZeroNumber.hasMatch(newValue)) {
      oldValue = newValue.substring(1);
      _setControllerText();
      _isValidateValue = false;
      return;
    }

    // Check if it is a valid number
    final result =
        T == int ? int.tryParse(newValue) : double.tryParse(newValue);
    if (result == null) {
      _setControllerText();
      _isValidateValue = false;
      return;
    }

    oldValue = newValue;
    _isValidateValue = false;
  }

  void _setControllerText() {
    oldValue = oldValue.trim().isEmpty ? '0' : oldValue.trim();
    text = oldValue;
    selection = TextSelection.fromPosition(
      TextPosition(offset: oldValue.length),
    );
  }
}
