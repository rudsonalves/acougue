import 'package:flutter/material.dart';

import '/domain/models/credentials.dart';
import '/routing/router.dart';
import '/ui/core/themes/dimens.dart';
import '/ui/core/ui/messages/app_snack_bar.dart';
import 'sign_up_view_model.dart';
import '/utils/validate.dart';
import '/ui/core/ui/buttons/text_row_button.dart';
import '/ui/core/ui/buttons/big_button.dart';
import '/ui/core/ui/text_fields/basic_text_field.dart';
import '/ui/core/ui/text_fields/secret_text_field.dart';

class SignUpPage extends StatefulWidget {
  final SignUpViewModel signUpViewModel;

  const SignUpPage({super.key, required this.signUpViewModel});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final SignUpViewModel _signUpViewModel;
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _signUpViewModel = widget.signUpViewModel;
    _signUpViewModel.signUp.addListener(_onSignUp);
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Dimens dimens = Dimens.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Conta'),
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: colorScheme.surfaceContainerLow,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: dimens.paddingScreenHorizontal,
            vertical: dimens.paddingScreenVertical,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: Dimens.of(context).spacingVertical,
                    children: [
                      BasicTextField(
                        labelText: 'Nome',
                        hintText: 'Digite seu nome.',
                        controller: _nameController,
                        prefixIcon: Icon(
                          Icons.email_rounded,
                          color: colorScheme.primary,
                        ),
                      ),
                      SecretTextField(
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
                      SecretTextField(
                        labelText: 'ConfirmarSenha',
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
                        onEditingComplete: _signUp,
                      ),
                      SizedBox(height: dimens.spacingVertical * 1),
                      ListenableBuilder(
                        listenable: _signUpViewModel.signUp,
                        builder: (context, _) {
                          return BigButton(
                            iconData: Icons.person_add_rounded,
                            isRunning: _signUpViewModel.signUp.running,
                            color: Colors.green,
                            label: 'Criar Conta',
                            onPressed: _signUp,
                          );
                        },
                      ),
                      TextRowButton(
                        labelText: 'Já possui um conta?',
                        textButton: 'Entrar!',
                        onPressed: _loginAccount,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    FocusScope.of(context).unfocus();
    // Return if the form is invalid
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }

    // Return if the request is running
    if (_signUpViewModel.signUp.running) {
      return;
    }

    final credentials = Credentials(
      name: _nameController.text,
      password: _passwordController.text,
    );

    _signUpViewModel.signUp.execute(credentials);
  }

  Future<void> _onSignUp() async {
    if (_signUpViewModel.signUp.running) return;

    final result = _signUpViewModel.signUp.result!;

    result.fold(
      onSuccess: (value) {
        AppSnackBar.showBottom(
          context,
          title: 'Parabéns',
          iconTitle: Icons.person_rounded,
          message:
              'Sua conta foi criada com sucesso!\n'
              'Verifique seu email para ativar sua conta e, '
              'em seguida poderá efetuar seu login.',
          duration: const Duration(seconds: 8),
        );

        if (mounted) Navigator.pushReplacementNamed(context, Routes.signin);
      },
      onFailure: (err) {
        final errorMessage =
            err.toString().contains('statusCode: 422')
                ? 'Email já cadastrado. Tente outro!'
                : 'Desculpe. Ocorreu um erro inesperado.'
                    ' Tente novamente mais tarde!';
        AppSnackBar.showBottom(
          context,
          title: 'Erro!',
          iconTitle: Icons.error_rounded,
          message: errorMessage,
          duration: const Duration(seconds: 5),
        );
      },
    );
  }

  void _loginAccount() {
    Navigator.pushReplacementNamed(context, Routes.signin);
  }
}
