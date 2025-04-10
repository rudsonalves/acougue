import '/domain/models/address.dart';
import '/utils/result.dart';

abstract class AddressRepository {
  Map<String, Address> get addresses;
  List<Address> get addressList;

  Future<Result<Address>> get(String id);
  Future<Result<void>> getAll();
  Future<Result<Address>> add(Address address);
  Future<Result<void>> update(Address address);
  Future<Result<void>> delete(String id);
}
