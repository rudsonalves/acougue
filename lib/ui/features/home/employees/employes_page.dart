import 'package:flutter/material.dart';

import 'package:acougue/routing/router.dart';
import 'package:acougue/ui/core/themes/dimens.dart';
import 'package:acougue/ui/features/home/employees/employees_view_model.dart';

class EmployesPage extends StatefulWidget {
  final EmployeesViewModel employeesViewModel;

  const EmployesPage({super.key, required this.employeesViewModel});

  @override
  State<EmployesPage> createState() => _EmployesPageState();
}

class _EmployesPageState extends State<EmployesPage> {
  late final EmployeesViewModel _employeesViewModel;

  @override
  void initState() {
    _employeesViewModel = widget.employeesViewModel;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dimens = Dimens.of(context);
    // final colorScheme = Theme.of(context).colorScheme;
    final usersInfo = _employeesViewModel.listUserInfo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionários'),
        centerTitle: true,
        elevation: 5,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dimens.paddingScreenHorizontal / 2,
          vertical: dimens.paddingScreenVertical,
        ),
        child: Column(
          spacing: dimens.spacingVertical,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: usersInfo.length,
              itemBuilder:
                  (context, index) => ListTile(
                    title: Text(usersInfo[index].name),
                    subtitle: Text(usersInfo[index].contact),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addUser() async {
    await Navigator.pushNamed(context, Routes.editUser);
    setState(() {});
  }
}
