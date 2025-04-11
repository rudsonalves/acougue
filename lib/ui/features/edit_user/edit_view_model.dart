import 'package:acougue/utils/logger.dart';

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
    update = Command1<User, User>(_update);
    add = Command1<User, User>(_add);
    getAddress = Command1<Address, String>(_getAddress);
    getUser = Command1<User, String>(_getUser);
  }

  late final Command1<User, User> update;
  late final Command1<User, User> add;
  late final Command1<Address, String> getAddress;
  late final Command1<User, String> getUser;

  User? get currentUser => _authRepository.user;
  Address? _address;
  Address? get address => _address;

  final logger = Logger('EditViewModel');

  Future<Result<User>> _update(User user) async {
    final result = await _authRepository.updateUser(user);
    await Future.delayed(const Duration(seconds: 1));

    result.fold(
      onSuccess: (user) {
        logger.info('_update', 'User updated');
      },
      onFailure: (err) {
        logger.critical('_update', 'Error: $err');
      },
    );

    return Result.success(user);
  }

  Future<Result<User>> _add(User user) async {
    final result = await _authRepository.addUser(user);
    await Future.delayed(const Duration(seconds: 1));

    result.fold(
      onSuccess: (user) {
        logger.info('_add', 'User added');
      },
      onFailure: (err) {
        logger.critical('_add', 'Error: $err');
      },
    );

    return Result.success(user);
  }

  Future<Result<Address>> _getAddress(String? id) async {
    if (id == null) return Result.failure(Exception('Address id is null'));

    final result = await _addressRepository.get(id);

    result.fold(
      onSuccess: (address) {
        _address = address;
        logger.info('_getAddress', 'Get address ${address.id}');
      },
      onFailure: (err) {
        _address = null;
        logger.critical('_getAddress', 'Address not found: $err');
      },
    );

    return result;
  }

  Future<Result<User>> _getUser(String? id) async {
    if (id == null) return Result.failure(Exception('User id is null'));

    final result = await _authRepository.getUser(id);

    result.fold(
      onSuccess: (address) {
        logger.info('_getUser', 'Get user ${address.id}');
      },
      onFailure: (err) {
        _address = null;
        logger.critical('_getUser', 'Address not found: $err');
      },
    );

    return result;
  }
}
