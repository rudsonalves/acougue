import 'package:flutter/material.dart';

import '/domain/models/butcher_shop.dart';
import '/ui/core/ui/buttons/big_button.dart';
import '/ui/core/ui/messages/app_snack_bar.dart';
import '/utils/extensions.dart';
import '/domain/models/address.dart';
import '/routing/router.dart';
import '/ui/core/themes/dimens.dart';
import '/ui/core/ui/text_fields/basic_text_field.dart';
import '/utils/validate.dart';
import '/ui/features/home/registrations/butcher_shop/butcher_shop_view_model.dart';

class ButcherShopPage extends StatefulWidget {
  final ButcherShopViewModel butcherShopViewModel;

  const ButcherShopPage({super.key, required this.butcherShopViewModel});

  @override
  State<ButcherShopPage> createState() => _ButcherShopPageState();
}

class _ButcherShopPageState extends State<ButcherShopPage> {
  late final ButcherShopViewModel _butcherShopViewModel;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _createdAtController = TextEditingController();
  String? _addressId;
  DateTime? _createdAt;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _butcherShopViewModel = widget.butcherShopViewModel;
    _butcherShopViewModel.update.addListener(_onUpdated);

    _addressId = _butcherShopViewModel.address?.id;
    _initializeForm();

    super.initState();
  }

  @override
  void dispose() {
    _butcherShopViewModel.update.removeListener(_onUpdated);

    _nameController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _createdAtController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dimens = Dimens.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editando Açougue'),
        centerTitle: true,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: dimens.paddingScreenHorizontal,
          vertical: dimens.paddingScreenVertical,
        ),
        child: Column(
          spacing: dimens.spacingVertical,
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
                    hintText: 'Nome do Açougue',
                    controller: _nameController,
                    validator: Validate.simple,
                    prefixIcon: Icon(
                      Icons.kebab_dining_rounded,
                      color: colorScheme.primary,
                    ),
                  ),
                  BasicTextField(
                    labelText: 'Descrição',
                    hintText: 'Descrição do Açougue',
                    controller: _descriptionController,
                    validator: Validate.simple,
                    prefixIcon: Icon(
                      Icons.description_rounded,
                      color: colorScheme.primary,
                    ),
                  ),
                  InkWell(
                    borderRadius: dimens.borderRadius,
                    onTap: _goToAddressPage,
                    child: AbsorbPointer(
                      child: BasicTextField(
                        labelText: 'Endereço',
                        hintText: 'Clique para adicionar um endereço.',
                        controller: _addressController,
                        readOnly: true,
                        prefixIcon: Icon(
                          Icons.contact_mail_rounded,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: dimens.borderRadius,
                    onTap: _getCreatedDate,
                    child: AbsorbPointer(
                      child: BasicTextField(
                        labelText: 'Criado em',
                        hintText: 'Coloque a data de criação do açougue.',
                        controller: _createdAtController,
                        readOnly: true,
                        prefixIcon: Icon(
                          Icons.calendar_month_rounded,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(dimens.paddingScreenAll * 3),
              child: ListenableBuilder(
                listenable: _butcherShopViewModel.update,
                builder: (context, _) {
                  return BigButton(
                    color: Colors.blueAccent,
                    isRunning: _butcherShopViewModel.update.running,
                    label: 'Atualizar',
                    iconData: Icons.update_rounded,
                    onPressed: _updateButton,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateButton() {
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
      return;
    }

    final butcher = ButcherShop(
      id: _butcherShopViewModel.butcherShop.id,
      name: _nameController.text,
      description: _descriptionController.text,
      addressId: _addressId,
      createdAt: _createdAt,
      updatedAt: DateTime.now(),
    );

    _butcherShopViewModel.update.execute(butcher);
  }

  Future<void> _getCreatedDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _createdAt = pickedDate;
      _createdAtController.text = _createdAt!.toBrString();
    }
  }

  void _goToAddressPage() {
    Navigator.pushNamed(
      context,
      Routes.address,
      arguments: {'callBack': _returningAddressPage, 'addressId': _addressId},
    );
  }

  void _returningAddressPage(Address address) {
    _addressId ??= address.id;

    _addressController.text = address.fullAddress;
  }

  Future<void> _initializeForm() async {
    await _butcherShopViewModel.getButcher.execute();
    final result = _butcherShopViewModel.getButcher.result!;

    result.fold(
      onSuccess: (butche) async {
        _nameController.text = butche.name;
        _descriptionController.text = butche.description;
        _addressId = butche.addressId;
        _createdAtController.text = (butche.createdAt as DateTime).toBrString();
        if (_addressId != null) {
          await _butcherShopViewModel.getAddress.execute(_addressId!);

          if (_butcherShopViewModel.address != null) {
            _addressController.text =
                _butcherShopViewModel.address!.fullAddress;
          }
        }

        setState(() {});
      },
      onFailure: (err) {
        _addressId = null;
      },
    );
  }

  void _onUpdated() {
    if (_butcherShopViewModel.update.running) return;

    final result = _butcherShopViewModel.update.result!;

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
}
