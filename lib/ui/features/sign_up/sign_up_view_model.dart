import 'dart:developer';

import '/domain/models/user.dart';
import '/data/repositories/auth/auth_repository.dart';
import '/utils/commands.dart';
import '/utils/result.dart';

class SignUpViewModel {
  final AuthRepository _authRepository;

  SignUpViewModel(this._authRepository) {
    signUp = Command1<void, User>(_signUp);
  }

  late final Command1 signUp;

  Future<Result<void>> _signUp(User user) async {
    try {
      final result = await _authRepository.addUser(user);

      result.fold(
        onSuccess: (value) {
          log('Login successful');
        },
        onFailure: (err) {
          log('Login failed: $err', level: 3);
        },
      );

      return result;
    } catch (err) {
      log('Login failed: $err', level: 5);
      rethrow;
    }
  }
}
