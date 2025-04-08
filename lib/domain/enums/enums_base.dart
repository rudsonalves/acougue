abstract class LabeledEnum {
  String get label;
}

extension EnumExtension<T extends Enum> on Iterable<T> {
  /// Returns the enum value from this collection whose name is equal to
  /// [name], or null if no such value exists.
  T? fromName(String name) {
    for (final value in this) {
      if (value.name == name) {
        return value;
      }
    }
    return null;
  }
}
