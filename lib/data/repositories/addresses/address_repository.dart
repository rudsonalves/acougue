import 'package:acougue/domain/models/address.dart';
import 'package:acougue/utils/result.dart';

abstract class AddressRepository {
  Future<Result<Address>> get(String id);
  Future<Result<Address>> add(Address address);
  Future<Result<void>> update(Address address);
  Future<Result<void>> delete(String id);
}
