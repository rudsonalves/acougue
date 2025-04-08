import 'package:acougue/routing/router.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed:
                  () => Navigator.pushReplacementNamed(context, Routes.signup),
              child: const Text('Ir para cadastro'),
            ),
          ],
        ),
      ),
    );
  }
}
