import 'package:acougue/utils/result.dart';
import 'package:flutter/material.dart';

typedef CommandAction0<Output> = Future<Result<Output>> Function();
typedef CommandAction1<Output, Input> = Future<Result<Output>> Function(Input);

/// Facilitates interaction with a ViewModel.
///
/// Encapsulates an action,
/// exposes its running and error states,
/// and ensures that it can't be launched again until it finishes.
///
/// Use [Command0] for actions without arguments.
/// Use [Command1] for actions with one argument.
///
/// Actions must return a [Result].
///
/// Consume the action result by listening to changes,
/// then call to [clearResult] when the state is consumed.
abstract class Command<Output> extends ChangeNotifier {
  Command();

  bool _running = false;

  /// True when the action is running.
  bool get running => _running;

  Result<Output>? _result;

  /// true if action completed with error
  bool get error => _result is Failure;

  /// true if action completed successfully
  bool get completed => _result is Success;

  /// Get last action result
  Result? get result => _result;

  /// Clear last action result
  void clearResult() {
    _result = null;
  }

  /// Internal execute implementation
  Future<void> _execute(CommandAction0<Output> action) async {
    // Ensure the action can't launch multiple times.
    // e.g. avoid multiple taps on button
    if (_running) return;

    // Notify listeners.
    // e.g. button shows loading state
    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

/// [Command] without arguments.
/// Takes a [CommandAction0] as action.
class Command0<Output> extends Command<Output> {
  final CommandAction0<Output> _action;

  Command0(this._action);

  /// Executes the action.
  Future<void> execute() async {
    await _execute(_action);
  }
}

/// [Command] with one argument.
/// Takes a [CommandAction1] as action.
class Command1<Output, Input> extends Command<Output> {
  final CommandAction1<Output, Input> _action;

  Command1(this._action);

  /// Executes the action with the argument.
  Future<void> execute(Input param) async {
    await _execute(() => _action(param));
  }
}
