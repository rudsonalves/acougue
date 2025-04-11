import 'dart:developer';

import '/data/repositories/auth/auth_repository.dart';
import '/utils/commands.dart';
import '/utils/result.dart';

class SplashViewModel {
  final AuthRepository authRepository;

  SplashViewModel(this.authRepository) {
    load = Command0(_load)..execute();
  }

  late Command0 load;

  String? get userId => authRepository.user?.id;

  Future<Result<void>> _load() async {
    final result = await authRepository.initialize();
    await Future.delayed(const Duration(seconds: 1));

    result.fold(
      onSuccess: (_) {
        log('Logged with default user');
      },
      onFailure: (err) {
        log('Error: $err');
      },
    );

    return result;
  }
}
