import 'dart:developer';

import '/data/repositories/addresses/address_repository.dart';
import '../common/collections.dart';
import '/domain/models/address.dart';
import '../../services/json_service.dart';
import '/utils/result.dart';

class LocalAddressRepository implements AddressRepository {
  final JsonService _jsonServer;

  LocalAddressRepository(this._jsonServer) {
    _initialize();
  }

  final _addresses = <String, Address>{};

  static const addressCollection = Collections.addresses;

  @override
  Map<String, Address> get addresses => _addresses;

  @override
  List<Address> get addressList => _addresses.values.toList();

  Future<void> _initialize() async {
    await getAll();
  }

  @override
  Future<Result<Address>> add(Address address) async {
    try {
      final uid = await _jsonServer.insertIntoCollection(
        addressCollection,
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
      final map = await _jsonServer.getFromCollection(addressCollection, id);

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
  Future<Result<void>> getAll() async {
    try {
      final listMaps = await _jsonServer.getAllFromCollection(
        addressCollection,
      );

      _addresses.clear();
      _addresses.addEntries(
        listMaps.map((map) => MapEntry(map['id'], Address.fromMap(map))),
      );

      return const Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await _jsonServer.removeFromCollection(addressCollection, id);
      return const Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }

  @override
  Future<Result<void>> update(Address address) async {
    try {
      await _jsonServer.updateInCollection(addressCollection, address.toMap());
      return const Result.success(null);
    } on Exception catch (err) {
      log(err.toString());
      return Result.failure(err);
    }
  }
}
