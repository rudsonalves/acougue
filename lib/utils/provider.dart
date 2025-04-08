import 'package:flutter/material.dart';

/// A provider that allows you to pass a function that returns a widget.
typedef ProviderBuilder = Widget Function(Widget child);

class MultiProvider extends InheritedWidget {
  MultiProvider({
    super.key,
    required List<ProviderBuilder> providers,
    required Widget child,
  }) : super(child: _buildProviders(providers, child));

  // Method that chains providers around the child widget.
  static Widget _buildProviders(List<ProviderBuilder> providers, Widget child) {
    return providers.reversed.fold(
      child,
      (previous, provider) => provider(previous),
    );
  }

  // No need to update the widget.
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

/// A provider that allows you to pass a value.
class SimpleProvider<T> extends InheritedWidget {
  final T value;

  const SimpleProvider({super.key, required this.value, required super.child});

  @override
  bool updateShouldNotify(covariant SimpleProvider<T> oldWidget) {
    return oldWidget.value != value;
  }

  static T of<T>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<SimpleProvider<T>>()!;
    return provider.value;
  }
}

/// A provider that allows you to pass a ChangeNotifier.
class NotifierProvider<T extends ChangeNotifier> extends InheritedNotifier<T> {
  final T? value;

  const NotifierProvider({super.key, required super.child, required this.value})
    : super(notifier: value);

  static T of<T extends ChangeNotifier>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<NotifierProvider<T>>()!;
    return provider.notifier!;
  }
}
