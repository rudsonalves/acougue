import '/data/repositories/freezers/freezers_repository.dart';
import '/domain/models/freezer.dart';
import '/utils/commands.dart';
import '/utils/logger.dart';
import '/utils/result.dart';

class FreezersViewModel {
  final FreezersRepository _freezersRepository;

  FreezersViewModel(this._freezersRepository) {
    save = Command1<Freezer, Freezer>(_save);
    update = Command1<void, Freezer>(_update);
  }

  late final Command1<Freezer, Freezer> save;
  late final Command1<void, Freezer> update;

  List<Freezer> get freezersList => _freezersRepository.freezersList;

  Freezer? getFreezer(String id) => _freezersRepository.getFreezer(id);

  final logger = Logger('EditFreezerViewModel');

  Future<Result<Freezer>> _save(Freezer address) async {
    final result = await _freezersRepository.add(address);

    await Future.delayed(const Duration(seconds: 1));

    result.fold(
      onSuccess: (newFreezer) {
        logger.info('_save', 'Freezer created');
      },
      onFailure: (err) {
        logger.critical('_save', 'Error: $err');
      },
    );

    return result;
  }

  Future<Result<void>> _update(Freezer address) async {
    final result = await _freezersRepository.update(address);

    await Future.delayed(const Duration(seconds: 1));

    result.fold(
      onSuccess: (_) {
        logger.info('_update', 'Freezer updated');
      },
      onFailure: (err) {
        logger.critical('_update', 'Error: $err');
      },
    );

    return result;
  }
}
