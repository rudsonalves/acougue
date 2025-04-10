import 'package:acougue/domain/models/freezer.dart';
import 'package:acougue/utils/result.dart';

abstract class FreezersRepository {
  Map<String, Freezer> get freezers;
  List<Freezer> get freezersList;
  Freezer? getFreezer(String id);

  Future<Result<Freezer>> add(Freezer freezer);
  Future<Result<Freezer>> get(String id);
  Future<Result<void>> getAll();
  Future<Result<Freezer>> update(Freezer freezer);
  Future<Result<void>> delete(String id);
}
