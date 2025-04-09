import 'dart:developer';

import 'package:flutter/material.dart';

import '/data/repositories/auth/auth_repository.dart';
import '/domain/models/credentials.dart';
import '/utils/commands.dart';
import '/utils/result.dart';

class SignInViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  SignInViewModel(this._authRepository) {
    signIn = Command1<void, Credentials>(_signIn);
  }

  late final Command1 signIn;

  Future<Result<void>> _signIn(Credentials credentials) async {
    try {
      final result = await _authRepository.signIn(credentials);
      await Future.delayed(const Duration(seconds: 2));

      result.fold(
        onSuccess: (value) {
          log('Login successful');
        },
        onFailure: (err) {
          log('Login failed: $err', level: 3);
        },
      );

      return result;
    } on Exception catch (err) {
      log('Login failed: $err', level: 5);
      return Result.failure(err);
    }
  }
}
