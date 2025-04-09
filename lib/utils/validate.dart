abstract final class Validate {
  static String? generic(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório.';
    }

    if (value.length < 5) {
      return 'Deve ter no mínimo 5 caracteres.';
    }
    return null;
  }

  /// Checks if a given email is valid.
  ///
  /// A email is valid if it is not null, not empty, and matches
  /// the regular expression `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$`.
  ///
  /// Returns null if the email is valid, otherwise returns an error message.
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-mail é obrigatório';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  /// Checks if a given password is valid.
  ///
  /// A password is valid if it is not null, not empty, has at least 6 characters,
  /// and contains at least one letter and one number.
  ///
  /// Returns null if the password is valid, otherwise returns an error message.
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }

    if (value.length < 6) {
      return 'Senha deve ter pelo menos 6 caracteres';
    }

    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');

    if (!passwordRegex.hasMatch(value)) {
      return 'Senha deve conter pelo menos uma letra e um número';
    }

    return null;
  }

  /// Checks if the given value is a valid confirmation of a given password.
  ///
  /// A value is a valid confirmation if it is not null, not empty, and equals the given password.
  ///
  /// Returns null if the value is valid, otherwise returns an error message.
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Confirmação de senha é obrigatória';
    }

    if (value != password) {
      return 'As senhas devem ser iguais';
    }

    return null;
  }
}
