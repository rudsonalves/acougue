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
  }

  late final Command1<Address, Address> save;
  late final Command1<void, Address> update;

  Future<Result<Address>> _save(Address address) async {
    final result = await _addressRepository.add(address);
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
}
