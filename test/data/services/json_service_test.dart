import 'dart:io';

import 'package:acougue/data/repositories/common/collections.dart';
import 'package:acougue/data/services/json_service.dart';
import 'package:acougue/domain/enums/enums.dart';
import 'package:acougue/domain/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testfile =
      '/home/rudson/Documents/Projects/Flutter/Apps/acougue/test/database.json';
  final dbServer = JsonService(testfile);

  setUp(() {});

  tearDownAll(() async {
    await File(testfile).delete();
  });

  group('JsonDatabaseService testes', () {
    test('Open and close database', () async {
      await dbServer.open();

      expect(dbServer.isOpen, true);
      expect(dbServer.loggedUser, isNull);

      await dbServer.close();

      expect(dbServer.isOpen, false);
      expect(dbServer.loggedUser, isNull);

      await dbServer.open();

      expect(dbServer.isOpen, true);
      expect(dbServer.loggedUser, isNull);
    });

    test('signIn/signOut with admin user', () async {
      final result = await dbServer.signIn('admin', 'password');
      expect(result, isNull);

      final result2 = await dbServer.signIn('admin', '123qwe');
      expect(result2, isNotNull);

      await dbServer.signOut();
      expect(dbServer.loggedUser, isNull);

      final result3 = await dbServer.signIn('carlos', '123qwe');
      expect(result3, isNull);
    });

    test('addUser/updateUser/removeUser', () async {
      final users = [
        User(
          name: 'Marcos Manager',
          addressId: '0',
          password: '123qwe',
          document: '',
          contact: '',
          position: Positions.manager,
        ),
        User(
          name: 'Marcos Admin',
          addressId: '0',
          password: '123qwe',
          document: '',
          contact: '',
          position: Positions.admin,
        ),
        User(
          name: 'Marcos Employee',
          addressId: '0',
          password: '123qwe',
          document: '',
          contact: '',
          position: Positions.employee,
        ),
        User(
          name: 'Marcos Employee 2',
          addressId: '0',
          password: '123qwe',
          document: '',
          contact: '',
          position: Positions.employee,
        ),
      ];

      final create1 = await dbServer.addUser(users[0]);
      expect(create1, isNull, reason: 'Admin não está logado.');

      // login with admin
      final user = await dbServer.signIn('admin', '123qwe');
      expect(user, isNotNull);
      final id2 = await dbServer.addUser(users[0]);
      expect(id2, isNotNull);

      // remove user
      final remove = await dbServer.removeUser(id2!);
      expect(remove, true);

      // Create all users
      final ids = [];
      for (final user in users) {
        final uid = await dbServer.addUser(user);
        expect(uid, isNotNull);
        ids.add(uid);
      }

      // logout admin
      await dbServer.signOut();
      expect(dbServer.loggedUser, isNull);

      // login with employee
      final employee = await dbServer.signIn(users[2].name, users[2].password!);
      expect(employee, isNotNull);
      expect(employee!.position.name, users[2].position.name);

      // employee can not remove any user
      for (final id in ids) {
        if (employee.id != id) {
          final remove = await dbServer.removeUser(id);
          expect(remove, false);
        }
      }

      // logout employee
      await dbServer.signOut();

      // login manager
      final manager = await dbServer.signIn(users[0].name, users[0].password!);
      expect(manager, isNotNull);
      expect(manager!.position.name, users[0].position.name);

      // manager can remove only employee
      for (final id in ids) {
        if (manager.id != id) {
          final remove = await dbServer.removeUser(id);
          if (ids.sublist(2).contains(id)) {
            expect(remove, true);
          } else {
            expect(remove, false);
          }
        }
      }

      // logout manager
      await dbServer.signOut();

      // login manager
      final admin = await dbServer.signIn('admin', '123qwe');
      expect(admin, isNotNull);
      expect(admin!.position.name, 'admin');

      // remove other users
      final rmIds = ids.sublist(0, 2);
      for (final id in rmIds) {
        final remove = await dbServer.removeUser(id);
        expect(remove, true);
      }
    });

    test('updateUser', () async {
      final user = User(
        name: 'Marcos Employee',
        addressId: '0',
        password: '123qwe',
        document: '',
        contact: '',
        position: Positions.employee,
      );

      // login manager
      final admin = await dbServer.signIn('admin', '123qwe');
      expect(admin, isNotNull);
      expect(admin!.position.name, 'admin');

      final userId = await dbServer.addUser(user);
      final newUser = user.copyWith(id: userId, document: 'CPF');

      // upgrade with admin
      final upgrade = await dbServer.updateUser(newUser);
      expect(upgrade, false);

      // logout admin
      await dbServer.signOut();

      // login user
      final login = await dbServer.signIn(newUser.name, newUser.password!);
      expect(login, isNotNull);

      // upgrade with admin
      final upgrade2 = await dbServer.updateUser(newUser);
      expect(upgrade2, true);
      expect(dbServer.loggedUser!.document, newUser.document);

      // upgrade with admin
      final newUser2 = user.copyWith(password: '123');
      final upgrade3 = await dbServer.updateUser(newUser2);
      expect(upgrade3, false);
    });
  });

  group('Collections testes', () {
    test('Tadas os métodos Collection', () async {
      final map = {'value': 'Teste'};
      final id = await dbServer.insertIntoCollection(
        Collections.addresses.name,
        map,
      );

      final map1 = await dbServer.getAllFromCollection(Collections.addresses);
      expect(map1.first['value'], map['value']);

      final map2 = await dbServer.getFromCollection(
        Collections.addresses.name,
        id,
      );
      expect(map2, isNotNull);
      expect(map2!['value'], map['value']);

      await expectLater(
        dbServer.removeFromCollection(Collections.addresses.name, id),
        completes,
      );

      await expectLater(
        dbServer.removeFromCollection(Collections.addresses.name, id),
        throwsException,
      );

      map.remove('id');
      final id2 = await dbServer.insertIntoCollection(
        Collections.addresses.name,
        map,
      );

      final map3 = {'id': id2, 'value': 'Teste 2'};

      await expectLater(
        dbServer.updateInCollection(Collections.addresses.name, map3),
        completes,
      );

      final map4 = await dbServer.getFromCollection(
        Collections.addresses.name,
        id2,
      );
      expect(map4, isNotNull);
      expect(map4!['value'], map3['value']);
    });
  });
}
