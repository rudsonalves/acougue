import 'dart:developer';

import '/data/repositories/addresses/address_repository.dart';
import '/data/repositories/common/app_constats.dart';
import '/domain/models/address.dart';
import '/data/services/json_database_service.dart';
import '/utils/result.dart';

class LocalAddressRepository implements AddressRepository {
  final JsonDatabaseService _database;

  LocalAddressRepository(this._database);

  final _addresses = <String, Address>{};

  Map<String, Address> get addresses => _addresses;

  List<Address> get addressList => _addresses.values.toList();

  @override
  Future<Result<Address>> add(Address address) async {
    try {
      final uid = await _database.insertIntoCollection(
        Collections.addresses,
        address.toMap(),
      );

      final newAddress = address.copyWith(id: uid);
      return Result.success(newAddress);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<Address>> get(String id) async {
    try {
      final map = await _database.getFromCollection(Collections.addresses, id);

      if (map == null) {
        return Result.failure(Exception('Address not found'));
      }

      final address = Address.fromMap(map);
      return Result.success(address);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await _database.removeFromCollection(Collections.addresses, id);
      return Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> update(Address address) async {
    try {
      await _database.updateInCollection(
        Collections.addresses,
        address.toMap(),
      );
      return Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }
}
