import 'package:flutter/material.dart';

import '/domain/models/credentials.dart';
import '/ui/core/themes/dimens.dart';
import '/ui/core/ui/buttons/big_button.dart';
import '/ui/core/ui/buttons/text_row_button.dart';
import '/ui/core/ui/messages/app_snack_bar.dart';
import '/ui/core/ui/text_fields/basic_text_field.dart';
import '/ui/core/ui/text_fields/secret_text_field.dart';
import '/utils/validate.dart';
import '../../core/ui/images/logo_image.dart';
import '/ui/features/sign_in/sign_in_view_model.dart';

class SignInPage extends StatefulWidget {
  final SignInViewModel signInViewModel;

  const SignInPage({super.key, required this.signInViewModel});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final SignInViewModel _signInViewModel;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _signInViewModel = widget.signInViewModel;
    _signInViewModel.signIn.addListener(_onLogin);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Dimens dimens = Dimens.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
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
              const LogoImage(radius: 80),
              SizedBox(height: dimens.spacingVertical * 2),
              Padding(
                padding: EdgeInsets.all(dimens.paddingScreenAll),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BasicTextField(
                        labelText: 'Nome',
                        hintText: 'Digite seu nome.',
                        controller: _emailController,
                        prefixIcon: Icon(
                          Icons.email_rounded,
                          color: colorScheme.primary,
                        ),
                      ),
                      Focus(
                        onFocusChange: (hasFocus) {
                          if (hasFocus) {
                            _passwordFocusNode.requestFocus();
                          }
                        },
                        child: TextRowButton(
                          labelText: 'Esqueceu a senha?',
                          textButton: 'Recuperar!',
                          onPressed: _recoverPassword,
                        ),
                      ),
                      SecretTextField(
                        labelText: 'Senha',
                        hintText: 'Digite uma senha de letras e números.',
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.done,
                        validator: Validate.password,
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          color: colorScheme.primary,
                        ),
                        onEditingComplete: _signIn,
                      ),
                      SizedBox(height: dimens.spacingVertical * 3),
                      ListenableBuilder(
                        listenable: _signInViewModel.signIn,
                        builder: (context, _) {
                          return BigButton(
                            iconData: Icons.login_rounded,
                            isRunning: _signInViewModel.signIn.running,
                            color: Colors.cyanAccent,
                            label: 'Entrar',
                            onPressed: _signIn,
                          );
                        },
                      ),
                      // TextRowButton(
                      //   labelText: 'Não possui conta?',
                      //   textButton: 'Criar conta!',
                      //   onPressed: _createAccount,
                      // ),
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

  void _onLogin() {
    if (_signInViewModel.signIn.running) return;

    final result = _signInViewModel.signIn.result!;

    result.fold(
      onSuccess: (user) {
        Navigator.pop(context);
      },
      onFailure: (err) {
        final erroMessage = 'Email ou senha inválidos! Tente novamente.';
        AppSnackBar.showBottom(
          context,
          title: 'Erro!',
          iconTitle: Icons.error_rounded,
          message: erroMessage,
          duration: const Duration(seconds: 5),
        );

        _signInViewModel.signIn.clearResult();
      },
    );
  }

  void _recoverPassword() {}

  // void _createAccount() {
  //   Navigator.pushReplacementNamed(context, Routes.signup);
  // }

  void _signIn() {
    FocusScope.of(context).unfocus();
    // Return if the form is not valid
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }

    // Return if the login is already running
    if (_signInViewModel.signIn.running) {
      return;
    }

    final credentials = Credentials(
      name: _emailController.text,
      password: _passwordController.text,
    );
    _signInViewModel.signIn.execute(credentials);
  }
}
