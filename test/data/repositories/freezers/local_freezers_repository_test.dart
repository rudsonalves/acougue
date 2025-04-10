import 'dart:io';

import 'package:acougue/data/repositories/freezers/local_freezers_repository.dart';
import 'package:acougue/data/services/json_service.dart';
import 'package:acougue/domain/models/freezer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testfile =
      '/home/rudson/Documents/Projects/Flutter/Apps/acougue/test/database.json';
  final dbServer = JsonService(testfile);
  final freezerRepository = LocalFreezersRepository(dbServer);

  setUp(() {});

  tearDownAll(() async {
    await File(testfile).delete();
  });

  group('TestaLocalFreezersRepository', () {
    test('Testa todos seus métodos', () async {
      final freezer0 = Freezer(
        name: 'Freezer 01',
        description: 'description',
        location: 'Sala de Freezers 01',
      );

      // Adiciona freezer
      final result1 = await freezerRepository.add(freezer0);
      expect(result1.isSuccess, true);
      expect(result1.value, isNotNull);
      final freezer1 = result1.value!;
      expect(freezer1.id, isNotNull);
      expect(freezer1.name, freezer0.name);
      expect(freezer1.description, freezer0.description);
      expect(freezer1.location, freezer0.location);

      // Recupera freezer
      final result2 = await freezerRepository.get(freezer1.id!);
      expect(result2.isSuccess, true);
      expect(result2.value, isNotNull);
      final freezer2 = result2.value!;
      expect(freezer2.id, freezer1.id);
      expect(freezer2.name, freezer1.name);
      expect(freezer2.description, freezer1.description);
      expect(freezer2.location, freezer1.location);

      // Atualiza freezer
      final freezer3 = freezer2.copyWith(name: 'Freezer 02');
      final result3 = await freezerRepository.update(freezer3);
      expect(result3.isSuccess, true);
      expect(result3.value, isNotNull);
      final freezer4 = result3.value!;
      expect(freezer4.id, freezer3.id);
      expect(freezer4.name, freezer3.name);
      expect(freezer4.description, freezer3.description);
      expect(freezer4.location, freezer3.location);

      // Remove freezer
      final result4 = await freezerRepository.delete(freezer4.id!);
      expect(result4.isSuccess, true);

      // Tenta recuperar freezer removido
      final result5 = await freezerRepository.get(freezer4.id!);
      expect(result5.isSuccess, false);
    });
  });
}
