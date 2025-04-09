import 'dart:developer';

import '/data/repositories/addresses/address_repository.dart';
import '/domain/models/address.dart';
import '/utils/commands.dart';
import '/utils/result.dart';

class AddressViewModel {
  final AddressRepository _addressRepository;

  AddressViewModel(this._addressRepository) {
    save = Command1<Address, Address>(_save);
    update = Command1<void, Address>(_update);
    getAddress = Command1<Address, String>(_getAddress);
  }

  late final Command1<Address, Address> save;
  late final Command1<void, Address> update;
  late final Command1<Address, String> getAddress;

  Address? _address;
  Address? get address => _address;

  Future<Result<Address>> _save(Address address) async {
    final result = await _addressRepository.add(address);
    _address = address;

    await Future.delayed(const Duration(seconds: 2));

    result.fold(
      onSuccess: (address) {
        log('Address created');
      },
      onFailure: (err) {
        log('Error: $err');
      },
    );

    return result;
  }

  Future<Result<void>> _update(Address address) async {
    final result = await _addressRepository.update(address);
    _address = address;

    await Future.delayed(const Duration(seconds: 2));

    result.fold(
      onSuccess: (address) {
        log('Address updated');
      },
      onFailure: (err) {
        log('Error: $err');
      },
    );

    return result;
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
