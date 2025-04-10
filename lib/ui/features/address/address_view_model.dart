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

    await Future.delayed(const Duration(seconds: 2));

    result.fold(
      onSuccess: (newAddress) {
        _address = newAddress;
        log('Address created');
      },
      onFailure: (err) {
        _address = null;
        log('Error: $err');
      },
    );

    return result;
  }

  Future<Result<void>> _update(Address address) async {
    final result = await _addressRepository.update(address);

    await Future.delayed(const Duration(seconds: 2));

    result.fold(
      onSuccess: (_) {
        _address = address;
        log('Address updated', level: 1);
      },
      onFailure: (err) {
        log('Error: $err', level: 3);
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
        log('Get address', level: 1);
      },
      onFailure: (err) {
        _address = null;
        log('Address not found: $err');
      },
    );

    return result;
  }
}
