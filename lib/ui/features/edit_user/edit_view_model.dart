import 'dart:developer';

import '/data/repositories/auth/auth_repository.dart';
import '/domain/models/user.dart';
import '/utils/commands.dart';
import '/utils/result.dart';

class EditViewModel {
  final AuthRepository _authRepository;

  EditViewModel(this._authRepository) {
    update = Command1<void, User>(_update);
  }

  late final Command1<void, User> update;

  User? get currentUser => _authRepository.user;

  Future<Result<User>> _update(User user) async {
    final result = await _authRepository.updateUser(user);

    result.fold(
      onSuccess: (user) {
        log('User updated');
      },
      onFailure: (err) {
        log('Error: $err');
      },
    );

    return Result.success(user);
  }
}
