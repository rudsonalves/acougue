import 'package:flutter/material.dart';

import '/domain/enums/enums.dart';
import '/routing/router.dart';
import '/ui/core/themes/dimens.dart';
import '/ui/core/ui/messages/center_message_page.dart';
import '/ui/features/home/registrations/freezers/view_models/edit_freezer_view_model.dart';

class FreezersPage extends StatefulWidget {
  final FreezersViewModel freezersViewModel;

  const FreezersPage({super.key, required this.freezersViewModel});

  @override
  State<FreezersPage> createState() => _FreezersPageState();
}

class _FreezersPageState extends State<FreezersPage> {
  late final FreezersViewModel _freezersViewModel;

  @override
  void initState() {
    _freezersViewModel = widget.freezersViewModel;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dimens = Dimens.of(context);
    final freezers = _freezersViewModel.freezersList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Freezers e Câmeras Frigoríficas'),
        centerTitle: true,
        elevation: 5,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddFreezer,
        child: const Icon(Icons.add),
      ),
      body:
          freezers.isEmpty
              ? const CenterMessagePage(
                iconData: Icons.warning_amber_rounded,
                message:
                    'Nenhum freezer cadastrado.\nPressione o botão "+"'
                    ' para adicionar.',
              )
              : Column(
                spacing: dimens.spacingVertical,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder:
                        (context, index) => ListTile(
                          leading: Icon(
                            freezers[index].type == FreezerType.freezer
                                ? Icons.kitchen_rounded
                                : Icons.ac_unit_rounded,
                          ),
                          title: Text(freezers[index].name),
                          subtitle: Text(
                            '${freezers[index].description} - '
                            '${freezers[index].location}',
                          ),
                          onTap: () => _goToEditFreezer(freezers[index].id!),
                        ),
                    itemCount: freezers.length,
                  ),
                ],
              ),
    );
  }

  Future<void> _goToAddFreezer() async {
    await Navigator.pushNamed(context, Routes.editFreezer);
    setState(() {});
  }

  Future<void> _goToEditFreezer(String freezerId) async {
    await Navigator.pushNamed(
      context,
      Routes.editFreezer,
      arguments: {'freezerId': freezerId},
    );
    setState(() {});
  }
}
