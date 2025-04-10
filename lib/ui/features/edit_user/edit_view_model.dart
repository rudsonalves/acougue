import 'dart:developer';

import '/data/repositories/addresses/address_repository.dart';
import '/domain/models/address.dart';
import '/data/repositories/auth/auth_repository.dart';
import '/domain/models/user.dart';
import '/utils/commands.dart';
import '/utils/result.dart';

class EditViewModel {
  final AuthRepository _authRepository;
  final AddressRepository _addressRepository;

  EditViewModel({
    required AuthRepository authRepository,
    required AddressRepository addressRepository,
  }) : _authRepository = authRepository,
       _addressRepository = addressRepository {
    update = Command1<void, User>(_update);
    getAddress = Command1<Address, String>(_getAddress);
  }

  late final Command1<void, User> update;
  late final Command1<Address, String> getAddress;

  User? get currentUser => _authRepository.user;
  Address? _address;
  Address? get address => _address;

  Future<Result<User>> _update(User user) async {
    final result = await _authRepository.updateUser(user);
    await Future.delayed(const Duration(seconds: 2));

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

  Future<Result<Address>> _getAddress(String? id) async {
    if (id == null) return Result.failure(Exception('Address is null'));

    final result = await _addressRepository.get(id);

    result.fold(
      onSuccess: (address) {
        _address = address;
      },
      onFailure: (err) {
        _address = null;
        log('Address not found: $err');
      },
    );

    return result;
  }
}
