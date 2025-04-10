import 'package:flutter/material.dart';

import '/domain/enums/enums.dart';
import '/domain/models/freezer.dart';
import '/ui/core/themes/dimens.dart';
import '/ui/core/ui/buttons/big_button.dart';
import '/ui/core/ui/customs_edit_controllers/numeric_edit_controller.dart';
import '/ui/core/ui/messages/app_snack_bar.dart';
import '/ui/core/ui/text_fields/basic_dropdown_fielt.dart';
import '/ui/core/ui/text_fields/basic_text_field.dart';
import '/ui/features/home/registrations/freezers/view_models/edit_freezer_view_model.dart';
import '/utils/validate.dart';

class EditFreezerPage extends StatefulWidget {
  final FreezersViewModel freezersViewModel;
  final String? freezerId;

  const EditFreezerPage({
    super.key,
    required this.freezersViewModel,
    this.freezerId,
  });

  @override
  State<EditFreezerPage> createState() => _EditFreezerPageState();
}

class _EditFreezerPageState extends State<EditFreezerPage> {
  late final FreezersViewModel _freezersViewModel;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _volumeController = NumericEditController<double>(initialValue: 400.0);
  final _piecesController = NumericEditController<int>(initialValue: 50);
  FreezerType _selectedFreezerType = FreezerType.freezer;
  bool _isUpdate = false;
  String? _freezerId;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _freezersViewModel = widget.freezersViewModel;
    _freezersViewModel.save.addListener(_onSaved);
    _freezersViewModel.update.addListener(_onUpdated);

    if (widget.freezerId != null) {
      _isUpdate = true;
      _freezerId = widget.freezerId;
      _initialize();
    }

    super.initState();
  }

  @override
  void dispose() {
    _freezersViewModel.save.removeListener(_onSaved);
    _freezersViewModel.update.removeListener(_onUpdated);

    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _volumeController.dispose();
    _piecesController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dimens = Dimens.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isUpdate ? 'Editar Freezer' : 'Adicionar Freezer'),
        centerTitle: true,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: dimens.paddingScreenHorizontal,
          vertical: dimens.paddingScreenVertical,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: Column(
                spacing: dimens.spacingVertical,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BasicTextField(
                    labelText: 'Nome',
                    hintText: 'Nome para o freezer',
                    controller: _nameController,
                    validator: Validate.simple,
                    prefixIcon: Icon(
                      Icons.feed_rounded,
                      color: colorScheme.primary,
                    ),
                  ),
                  BasicTextField(
                    labelText: 'Descrição',
                    hintText: 'Descrição para o freezer',
                    controller: _descriptionController,
                    validator: Validate.simple,
                    prefixIcon: Icon(
                      Icons.menu_book_rounded,
                      color: colorScheme.primary,
                    ),
                  ),
                  BasicTextField(
                    labelText: 'Localização',
                    hintText: 'Descrição descreva a localização',
                    controller: _locationController,
                    validator: Validate.simple,
                    prefixIcon: Icon(
                      Icons.description_rounded,
                      color: colorScheme.primary,
                    ),
                  ),
                  Row(
                    spacing: dimens.spacingHorizontal,
                    children: [
                      Expanded(
                        flex: 2,
                        child: BasicDropdownField<FreezerType>(
                          value: _selectedFreezerType,
                          labelText: 'Tipo de Endereço',
                          prefixIcon: Icon(
                            Icons.kitchen_rounded,
                            color: colorScheme.primary,
                          ),
                          items: FreezerType.values,
                          itemLabel: (addressType) => addressType.label,
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedFreezerType = value;
                            });
                          },
                        ),
                      ),
                      _selectedFreezerType == FreezerType.freezer
                          ? Expanded(
                            child: BasicTextField(
                              labelText: 'Volume (litros)',
                              hintText: 'Volume total do freezer.',
                              controller: _volumeController,
                              validator: Validate.simple,
                              prefixIcon: Icon(
                                Icons.view_in_ar_rounded,
                                color: colorScheme.primary,
                              ),
                            ),
                          )
                          : Expanded(
                            child: BasicTextField(
                              labelText: 'Peças (Unidades)',
                              hintText:
                                  'Máximo número de peças armazenáveis na'
                                  ' Câmera Frigorífica',
                              controller: _piecesController,
                              validator: Validate.simple,
                              prefixIcon: Icon(
                                Icons.numbers_rounded,
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(dimens.paddingScreenAll * 3),
              child: ListenableBuilder(
                listenable:
                    _isUpdate
                        ? _freezersViewModel.update
                        : _freezersViewModel.save,
                builder: (context, _) {
                  return BigButton(
                    color: Colors.blueAccent,
                    isRunning:
                        _isUpdate
                            ? _freezersViewModel.update.running
                            : _freezersViewModel.save.running,
                    label: _isUpdate ? 'Atualizar' : 'Salvar',
                    iconData:
                        _isUpdate ? Icons.update_rounded : Icons.save_rounded,
                    onPressed: _saveButton,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveButton() {
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
      return;
    }

    final freezer = Freezer(
      id: _freezerId,
      name: _nameController.text,
      description: _descriptionController.text,
      type: _selectedFreezerType,
      location: _locationController.text,
      volume: _volumeController.numericValue,
      pieces: _piecesController.numericValue,
    );

    if (_isUpdate) {
      _freezersViewModel.update.execute(freezer);
    } else {
      _freezersViewModel.save.execute(freezer);
    }
  }

  void _onSaved() {
    if (_freezersViewModel.save.running) return;

    final result = _freezersViewModel.save.result!;

    result.fold(
      onSuccess: (address) {
        Navigator.pop(context);
      },
      onFailure: (err) {
        final erroMessage = 'Desculpe. Ocorreu um erro inesperado.\n$err';
        AppSnackBar.showBottom(
          context,
          title: 'Erro!',
          iconTitle: Icons.error_rounded,
          message: erroMessage,
          duration: const Duration(seconds: 5),
        );
      },
    );
  }

  void _onUpdated() {
    if (_freezersViewModel.update.running) return;

    final result = _freezersViewModel.update.result!;

    result.fold(
      onSuccess: (_) {
        Navigator.pop(context);
      },
      onFailure: (err) {
        final erroMessage = 'Desculpe. Ocorreu um erro inesperado.\n$err';
        AppSnackBar.showBottom(
          context,
          title: 'Erro!',
          iconTitle: Icons.error_rounded,
          message: erroMessage,
          duration: const Duration(seconds: 5),
        );
      },
    );
  }

  Future<void> _initialize() async {
    final freezer = _freezersViewModel.getFreezer(_freezerId!);

    if (freezer != null) {
      setState(() {
        _nameController.text = freezer.name;
        _descriptionController.text = freezer.description;
        _locationController.text = freezer.location;
        _selectedFreezerType = freezer.type;
        _volumeController.numericValue = freezer.volume;
        _piecesController.numericValue = freezer.pieces;
      });
    }
  }
}
