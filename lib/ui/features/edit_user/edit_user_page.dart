import 'package:acougue/routing/router.dart';
import 'package:acougue/ui/core/ui/messages/app_snack_bar.dart';
import 'package:flutter/material.dart';

import '/domain/enums/enums.dart';
import '/domain/models/user.dart';
import '/ui/core/themes/dimens.dart';
import '/ui/core/ui/buttons/big_button.dart';
import '/ui/core/ui/images/logo_image.dart';
import '/ui/core/ui/text_fields/basic_dropdown_fielt.dart';
import '/ui/core/ui/text_fields/basic_text_field.dart';
import '/ui/core/ui/text_fields/secret_text_field.dart';
import '/utils/validate.dart';
import '/ui/features/edit_user/edit_view_model.dart';

class EditUserPage extends StatefulWidget {
  final EditViewModel editViewModel;

  const EditUserPage({super.key, required this.editViewModel});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late final EditViewModel _editViewModel;
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _documentController = TextEditingController();
  Positions _selectedPosition = Positions.employee;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _editViewModel = widget.editViewModel;
    _editViewModel.update.addListener(_onUpdate);
    _initializeForm();

    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _addressFocusNode.dispose();

    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _documentController.dispose();

    _editViewModel.update.removeListener(_onUpdate);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dimens = Dimens.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualize os dados de sua Conta'),
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
                  Row(
                    spacing: dimens.spacingHorizontal * 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: BasicTextField(
                          labelText: 'Nome/Apelido',
                          hintText:
                              'Identidade para logar no sistema. '
                              'Deve ser único no sistema.',
                          controller: _nameController,
                          prefixIcon: Icon(
                            Icons.person_rounded,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: BasicDropdownField<Positions>(
                          value: _selectedPosition,
                          labelText: 'Cargo',
                          prefixIcon: Icon(
                            Icons.account_box_rounded,
                            color: colorScheme.primary,
                          ),
                          items: Positions.values,
                          itemLabel: (position) => position.label,
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedPosition = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: dimens.spacingHorizontal * 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SecretTextField(
                          labelText: 'Senha',
                          hintText: 'Digite uma senha de letras e números.',
                          focusNode: _passwordFocusNode,
                          controller: _passwordController,
                          validator: Validate.password,
                          prefixIcon: Icon(
                            Icons.lock_rounded,
                            color: colorScheme.primary,
                          ),
                          onEditingComplete: () {
                            _passwordFocusNode.unfocus();
                            FocusScope.of(
                              context,
                            ).requestFocus(_confirmPasswordFocusNode);
                          },
                        ),
                      ),
                      Expanded(
                        child: SecretTextField(
                          labelText: 'Confirmar Senha',
                          hintText: 'Digite novamente sua senha.',
                          textInputAction: TextInputAction.done,
                          controller: _confirmPasswordController,
                          validator:
                              (value) => Validate.confirmPassword(
                                value,
                                _passwordController.text,
                              ),
                          focusNode: _confirmPasswordFocusNode,

                          prefixIcon: Icon(
                            Icons.lock_rounded,
                            color: colorScheme.primary,
                          ),
                          onEditingComplete: () {
                            _passwordFocusNode.unfocus();
                            FocusScope.of(
                              context,
                            ).requestFocus(_addressFocusNode);
                          },
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    borderRadius: dimens.borderRadius,
                    onTap: _goToAddressPage,
                    child: AbsorbPointer(
                      child: BasicTextField(
                        labelText: 'Endereço',
                        hintText: 'Clique para adicionar um endereço.',
                        controller: _addressController,
                        validator:
                            _selectedPosition == Positions.admin
                                ? null
                                : Validate.generic,
                        focusNode: _addressFocusNode,
                        prefixIcon: Icon(
                          Icons.contact_mail_rounded,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  BasicTextField(
                    labelText: 'Contato',
                    hintText: 'Adicione um telefone para contato.',
                    controller: _contactController,
                    validator: Validate.generic,
                    // focusNode: _contactFocusNode,
                    prefixIcon: Icon(
                      Icons.contact_phone_rounded,
                      color: colorScheme.primary,
                    ),
                  ),
                  BasicTextField(
                    labelText: 'Documento (RG/CNH)',
                    hintText: 'Número de seu RG ou CNH',
                    controller: _documentController,
                    keyboardType: TextInputType.number,
                    validator: Validate.generic,
                    prefixIcon: Icon(
                      Icons.badge_rounded,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(dimens.paddingScreenAll * 3),
              child: ListenableBuilder(
                listenable: _editViewModel.update,
                builder: (context, _) {
                  return BigButton(
                    color: colorScheme.primary,
                    label: 'Atualizar',
                    iconData: Icons.update_rounded,
                    isRunning: _editViewModel.update.running,
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

  Future<void> _updateButton() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }

    final currentUser = _editViewModel.currentUser!;

    User user = User(
      id: currentUser.id,
      name: _nameController.text,
      addressId: null,
      document: _documentController.text,
      contact: _contactController.text,
      position: _selectedPosition,
      password: _passwordController.text,
      createdAt: currentUser.createdAt,
      updatedAt: DateTime.now(),
    );

    _editViewModel.update.execute(user);
  }

  Future<void> _onUpdate() async {
    if (_editViewModel.update.running) return;

    final result = _editViewModel.update.result!;

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

  void _initializeForm() {
    final user = _editViewModel.currentUser;

    if (user == null) return;

    _nameController.text = user.name;
    _selectedPosition = user.position;
    _passwordController.text = user.password ?? '';
    _confirmPasswordController.text = user.password ?? '';
    _contactController.text = user.contact;
    _documentController.text = user.document;
  }

  void _goToAddressPage() {
    Navigator.pushNamed(context, Routes.address);
  }
}
