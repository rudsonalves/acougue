import 'dart:developer';

import '/data/repositories/addresses/address_repository.dart';
import '/domain/models/address.dart';
import '/data/repositories/butcher_shop/butcher_shop_repository.dart';
import '/domain/models/butcher_shop.dart';
import '/utils/commands.dart';
import '/utils/result.dart';

class ButcherShopViewModel {
  final ButcherShopRepository _butcherShopRepository;
  final AddressRepository _addressRepository;

  ButcherShopViewModel({
    required ButcherShopRepository butcherShopRepository,
    required AddressRepository addressRepository,
  }) : _butcherShopRepository = butcherShopRepository,
       _addressRepository = addressRepository {
    update = Command1<void, ButcherShop>(_update);
    getButcher = Command0<ButcherShop>(_getButcher);
    getAddress = Command1<Address, String>(_getAddress);
  }

  late final Command1<void, ButcherShop> update;
  late final Command0<ButcherShop> getButcher;
  late final Command1<Address, String> getAddress;

  ButcherShop get butcherShop => _butcherShopRepository.butcher!;

  Address? _address;
  Address? get address => _address;
  Map<String, Address> get addresses => _addressRepository.addresses;

  Future<Result<void>> _update(ButcherShop butcher) async {
    final result = await _butcherShopRepository.update(butcher);

    await Future.delayed(const Duration(seconds: 2));

    result.fold(
      onSuccess: (_) {
        log('ButcherShop updated', level: 1);
      },
      onFailure: (err) {
        log('Error: $err', level: 3);
      },
    );

    return result;
  }

  Future<Result<ButcherShop>> _getButcher() async {
    final result = await _butcherShopRepository.get();

    result.fold(
      onSuccess: (butcher) {
        log('Get butcher', level: 1);
      },
      onFailure: (err) {
        log('Butcher Shop not found: $err', level: 3);
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
