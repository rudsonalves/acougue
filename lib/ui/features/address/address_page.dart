import 'dart:developer';

import 'package:flutter/material.dart';

import '/domain/enums/enums.dart';
import '/domain/models/address.dart';
import '/ui/core/themes/dimens.dart';
import '/ui/core/ui/buttons/big_button.dart';
import '/ui/core/ui/images/logo_image.dart';
import '/ui/core/ui/messages/app_snack_bar.dart';
import '/ui/core/ui/text_fields/basic_dropdown_fielt.dart';
import '/ui/core/ui/text_fields/basic_text_field.dart';
import '/utils/validate.dart';
import '/ui/features/address/address_view_model.dart';

class AddressPage extends StatefulWidget {
  final AddressViewModel addressViewModel;
  final void Function(Address address) callBack;
  final String? addressId;

  const AddressPage({
    super.key,
    this.addressId,
    required this.addressViewModel,
    required this.callBack,
  });

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  late final AddressViewModel _addressViewModel;

  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _complementController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  AddressType _selectedAddressType = AddressType.residential;
  BrStates? _selectedState;
  String? _addressId;
  bool _isUpdate = false;

  @override
  void initState() {
    _addressViewModel = widget.addressViewModel;
    _addressViewModel.save.addListener(_onSaved);
    _addressViewModel.update.addListener(_onUpdated);
    _addressId = widget.addressId;

    if (_addressId != null && _addressId!.trim().isNotEmpty) {
      _isUpdate = true;
      _initialize();
    }

    super.initState();
  }

  @override
  void dispose() {
    _streetController.dispose();
    _numberController.dispose();
    _complementController.dispose();
    _neighborhoodController.dispose();
    _zipCodeController.dispose();
    _cityController.dispose();

    _addressViewModel.save.removeListener(_onSaved);
    _addressViewModel.update.removeListener(_onUpdated);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dimens = Dimens.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isUpdate ? 'Editar Endereço' : 'Criar Endereço'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: dimens.paddingScreenHorizontal,
          vertical: dimens.paddingScreenVertical,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: dimens.paddingScreenAll * 2),
              child: const LogoImage(radius: 80),
            ),
            Form(
              key: _formKey,
              child: Column(
                spacing: dimens.spacingVertical,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BasicDropdownField<AddressType>(
                    value: _selectedAddressType,
                    labelText: 'Tipo de Endereço',
                    prefixIcon: Icon(
                      Icons.maps_home_work_rounded,
                      color: colorScheme.primary,
                    ),
                    items: AddressType.values,
                    itemLabel: (addressType) => addressType.label,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedAddressType = value;
                      });
                    },
                  ),
                  Row(
                    spacing: dimens.spacingHorizontal * 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: BasicTextField(
                          labelText: 'Av./Rua',
                          hintText: 'Nome da Rua/Avenida',
                          controller: _streetController,
                          validator: Validate.simple,
                          prefixIcon: Icon(
                            Icons.signpost_rounded,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: BasicTextField(
                          labelText: 'Número',
                          hintText: 'Número da casa, prédio,loja, etc.',
                          controller: _numberController,
                          validator: Validate.simple,
                          prefixIcon: Icon(
                            Icons.numbers_rounded,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  BasicTextField(
                    labelText: 'Complemento',
                    hintText: 'Condomínio, apartamento, etc.',
                    controller: _complementController,
                    prefixIcon: Icon(
                      Icons.domain_add_rounded,
                      color: colorScheme.primary,
                    ),
                  ),
                  Row(
                    spacing: dimens.spacingHorizontal * 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: BasicTextField(
                          labelText: 'CEP',
                          hintText: 'Número de seu CEP.',
                          controller: _zipCodeController,
                          validator: Validate.docNumber,
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: BasicTextField(
                          labelText: 'Bairro',
                          hintText: 'Bairro',
                          controller: _neighborhoodController,
                          validator: Validate.simple,
                          prefixIcon: Icon(
                            Icons.map_rounded,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: dimens.spacingHorizontal * 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: BasicTextField(
                          labelText: 'Cidade',
                          hintText: 'Nome da cidade.',
                          controller: _cityController,
                          validator: Validate.simple,
                          prefixIcon: Icon(
                            Icons.location_city_rounded,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: BasicDropdownField<BrStates>(
                          value: _selectedState,
                          labelText: 'Estado',
                          hintText: 'Selecione seu estado.',
                          prefixIcon: Icon(
                            Icons.maps_home_work_rounded,
                            color: colorScheme.primary,
                          ),
                          items: BrStates.values,
                          itemLabel: (addressType) => addressType.label,
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedState = value;
                            });
                          },
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
                        ? _addressViewModel.update
                        : _addressViewModel.save,
                builder: (context, _) {
                  return BigButton(
                    color: Colors.blueAccent,
                    isRunning:
                        _isUpdate
                            ? _addressViewModel.update.running
                            : _addressViewModel.save.running,
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
    if (_formKey.currentState == null ||
        !_formKey.currentState!.validate() ||
        _selectedState == null) {
      return;
    }

    final address = Address(
      id: _isUpdate ? _addressId : null,
      type: _selectedAddressType,
      street: _streetController.text,
      number: _numberController.text,
      complement: _complementController.text,
      cep: _zipCodeController.text,
      neighborhood: _neighborhoodController.text,
      city: _cityController.text,
      state: _selectedState!.name,
    );

    if (_isUpdate) {
      _addressViewModel.update.execute(address);
    } else {
      _addressViewModel.save.execute(address);
    }
  }

  void _onSaved() {
    if (_addressViewModel.save.running) return;

    final result = _addressViewModel.save.result!;

    result.fold(
      onSuccess: (address) {
        widget.callBack(address);
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
    if (_addressViewModel.update.running) return;

    final result = _addressViewModel.update.result!;

    result.fold(
      onSuccess: (_) {
        widget.callBack(_addressViewModel.address!);
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
    await _addressViewModel.getAddress.execute(_addressId!);
    final result = _addressViewModel.getAddress.result!;

    result.fold(
      onSuccess: (address) {
        _streetController.text = address.street;
        _numberController.text = address.number;
        _complementController.text = address.complement!;
        _neighborhoodController.text = address.neighborhood;
        _zipCodeController.text = address.cep;
        _cityController.text = address.city;
        _selectedState = BrStates.values.byName(address.state);
        _selectedAddressType = address.type;

        setState(() {});
      },
      onFailure: (err) {
        log('Error: $err');
      },
    );
  }
}
