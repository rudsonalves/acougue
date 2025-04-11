import 'package:flutter/material.dart';

import 'package:acougue/domain/models/product.dart';
import 'package:acougue/ui/core/ui/messages/app_snack_bar.dart';
import '/domain/models/freezer.dart';
import '/ui/core/ui/buttons/big_button.dart';
import '/ui/core/ui/customs_edit_controllers/numeric_edit_controller.dart';
import '/ui/core/ui/text_fields/basic_text_field.dart';
import '/utils/extensions.dart';
import '/utils/validate.dart';
import '/domain/enums/enums.dart';
import '/ui/core/themes/dimens.dart';
import '/ui/core/ui/text_fields/basic_dropdown_fielt.dart';
import '/ui/features/home/edit_product/product_view_model.dart';

class EditProductPage extends StatefulWidget {
  final ProductViewModel productsViewModel;
  final String? productId;

  const EditProductPage({
    super.key,
    required this.productsViewModel,
    this.productId,
  });

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late final ProductViewModel _productsViewModel;

  final _weightController = NumericEditController<double>(initialValue: 0.0);
  final _commentsController = TextEditingController();
  final _inputDateController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _employeeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  CutsType _selectedCutsType = CutsType.retailCuts;
  PrimalCuts? _selectedPrimalCut;
  RetailCuts? _selectedRetailCut;
  DateTime _inputDate = DateTime.now();
  late DateTime _expirationDate;
  Freezer? _selectedFreezer;
  String? _employeeId;

  bool _isUpdate = false;
  String? _productId;

  @override
  void initState() {
    _productsViewModel = widget.productsViewModel;

    _productsViewModel.save.addListener(_onSaved);
    _productsViewModel.update.addListener(_onUpdated);

    _expirationDate = _inputDate.add(const Duration(days: 30));
    _inputDateController.text = _inputDate.toBrString();
    _expirationDateController.text = _expirationDate.toBrString();

    _productId = widget.productId;

    if (_productId != null && _productId!.trim().isNotEmpty) {
      _isUpdate = true;
      _initialize();
    }

    super.initState();
  }

  @override
  void dispose() {
    _productsViewModel.save.removeListener(_onSaved);
    _productsViewModel.update.removeListener(_onUpdated);

    _weightController.dispose();
    _commentsController.dispose();
    _inputDateController.dispose();
    _expirationDateController.dispose();
    _employeeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dimens = Dimens.of(context);
    final freezersList = _productsViewModel.freezersList;
    _employeeController.text = _productsViewModel.user.name;
    _employeeId = _productsViewModel.user.id;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isUpdate ? 'Editar Produto' : 'Criar Produto'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dimens.paddingScreenHorizontal,
          vertical: dimens.paddingScreenVertical,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            spacing: dimens.spacingVertical,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                spacing: dimens.spacingHorizontal,
                children: [
                  Expanded(
                    child: BasicDropdownField<CutsType>(
                      value: _selectedCutsType,
                      labelText: 'Tipo de Base',
                      prefixIcon: Icon(
                        Icons.cut_rounded,
                        color: colorScheme.primary,
                      ),
                      items: CutsType.values,
                      itemLabel: (cutType) => cutType.label,
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _selectedCutsType = value;
                        });
                      },
                    ),
                  ),
                  if (_selectedCutsType == CutsType.primalCuts)
                    Expanded(
                      child: BasicDropdownField<PrimalCuts>(
                        value: _selectedPrimalCut,
                        labelText: 'Tipos de Corte Primário',
                        prefixIcon: Icon(
                          Icons.storefront_rounded,
                          color: colorScheme.primary,
                        ),
                        items: PrimalCuts.values,
                        itemLabel: (primalCut) => primalCut.label,
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedPrimalCut = value;
                          });
                        },
                      ),
                    ),
                  if (_selectedCutsType == CutsType.retailCuts)
                    Expanded(
                      child: BasicDropdownField<RetailCuts>(
                        value: _selectedRetailCut,
                        labelText: 'Tipo de Corte Comercial',
                        prefixIcon: Icon(
                          Icons.store_rounded,
                          color: colorScheme.primary,
                        ),
                        items: RetailCuts.values,
                        itemLabel: (retailCut) => retailCut.label,
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedRetailCut = value;
                          });
                        },
                      ),
                    ),
                ],
              ),
              Row(
                spacing: dimens.spacingHorizontal,
                children: [
                  Expanded(
                    flex: 2,
                    child: BasicTextField(
                      labelText: 'Comentários',
                      hintText: 'Adicionar comentários pertinentes.',
                      controller: _commentsController,
                      // validator: Validate.simple,
                      prefixIcon: Icon(
                        Icons.comment_rounded,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BasicTextField(
                      labelText: 'Peso (kg)',
                      hintText: 'Peso total da peça.',
                      controller: _weightController,
                      validator: Validate.simple,
                      prefixIcon: Icon(
                        Icons.balance_rounded,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: dimens.spacingHorizontal,
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: dimens.borderRadius,
                      onTap: _getInputDate,
                      child: AbsorbPointer(
                        child: BasicTextField(
                          labelText: 'Data de Entrada',
                          hintText: 'Coloque a data de entrada do produto.',
                          controller: _inputDateController,
                          readOnly: true,
                          prefixIcon: Icon(
                            Icons.calendar_month_rounded,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      borderRadius: dimens.borderRadius,
                      onTap: _getInputDate,
                      child: AbsorbPointer(
                        child: BasicTextField(
                          labelText: 'Data de Validade',
                          hintText: 'Selecione a data de validade do produto.',
                          controller: _expirationDateController,
                          readOnly: true,
                          prefixIcon: Icon(
                            Icons.calendar_month_rounded,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: dimens.spacingHorizontal,
                children: [
                  Expanded(
                    flex: 2,
                    child: BasicDropdownField<Freezer>(
                      value: _selectedFreezer,
                      labelText: 'Armazenado em',
                      prefixIcon: Icon(
                        Icons.kitchen_rounded,
                        color: colorScheme.primary,
                      ),
                      items: freezersList,
                      itemLabel: (freezer) => freezer.name,
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _selectedFreezer = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: BasicTextField(
                      labelText: 'Lançado por',
                      controller: _employeeController,
                      readOnly: true,
                      prefixIcon: Icon(
                        Icons.person_2_rounded,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(dimens.paddingScreenAll * 3),
                child: ListenableBuilder(
                  listenable:
                      _isUpdate
                          ? _productsViewModel.update
                          : _productsViewModel.save,
                  builder: (context, _) {
                    return BigButton(
                      color: Colors.blueAccent,
                      isRunning:
                          _isUpdate
                              ? _productsViewModel.update.running
                              : _productsViewModel.save.running,
                      label: _isUpdate ? 'Atualizar' : 'Salvar',
                      iconData: Icons.update_rounded,
                      onPressed: _saveButton,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveButton() {
    if (_formKey.currentState == null ||
        !_formKey.currentState!.validate() ||
        _selectedFreezer == null) {
      return;
    }

    final product = Product(
      id: _isUpdate ? _productId : null,
      cutType: _selectedCutsType,
      primalCut: _selectedPrimalCut,
      retailCuts: _selectedRetailCut,
      comments: _commentsController.text,
      freezerId: _selectedFreezer!.id!,
      employeeId: _employeeId!,
      weight: _weightController.numericValue,
      inputDate: _inputDate,
      expirationDate: _expirationDate,
    );

    if (_isUpdate) {
      _productsViewModel.update.execute(product);
    } else {
      _productsViewModel.save.execute(product);
    }
  }

  void _onSaved() {
    if (_productsViewModel.save.running) return;

    final result = _productsViewModel.save.result!;

    result.fold(
      onSuccess: (product) {
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
    if (_productsViewModel.update.running) return;

    final result = _productsViewModel.update.result!;

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

  Future<void> _getInputDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _inputDate = pickedDate;
      _inputDateController.text = _inputDate.toBrString();
    }
  }

  Future<void> _initialize() async {
    await _productsViewModel.getProduct.execute(_productId!);

    final result = _productsViewModel.getProduct.result!;

    if (result.isFailure) return;

    final product = result.value as Product;

    final freezersList = _productsViewModel.freezersList;

    _selectedCutsType = product.cutType;
    _selectedPrimalCut = product.primalCut;
    _selectedRetailCut = product.retailCuts;
    _commentsController.text = product.comments ?? '';
    _selectedFreezer = freezersList.lastWhere(
      (freezer) => freezer.id == product.freezerId,
    );
    _employeeId = product.employeeId;
    _weightController.numericValue = product.weight;
    _inputDate = product.inputDate;
    _expirationDate = product.expirationDate;
  }
}
