/// Utility class to wrap result data
///
/// Evaluate the result using a switch statement:
/// ```dart
/// result.fold(
///   onSuccess: (value) {
///     print(value);
///   },
///   onFailure: (err) {
///     print(error)
///   }
/// );
/// ```
sealed class Result<T> {
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.success(T value) = Success._;

  /// Creates an error [Result], completed with the specified [error].
  const factory Result.failure(Exception error) = Failure._;

  /// Returned true if Result is Success
  bool get isSuccess => this is Success<T>;

  /// Returned true if Result is Failure
  bool get isFailure => this is Failure<T>;

  /// Returned value is success
  T? get value => isSuccess ? (this as Success<T>).value : null;

  /// Returned error is failure
  Exception? get error => isFailure ? (this as Failure<T>).error : null;

  /// Pattern-matching handler for [Result].
  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(Exception error) onFailure,
  }) {
    return switch (this) {
      Success<T> result => onSuccess(result.value),
      Failure<T> result => onFailure(result.error),
    };
  }
}

/// Subclass of Result for values
final class Success<T> extends Result<T> {
  final T _value;

  const Success._(this._value);

  /// Returned value in result
  @override
  T get value => _value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// Subclass of Result for failure
final class Failure<T> extends Result<T> {
  final Exception _error;

  const Failure._(this._error);

  /// Returned error in result
  @override
  Exception get error => _error;

  @override
  String toString() => 'Result<$T>.error($error)';
}
