import 'package:acougue/routing/router.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed:
                  () => Navigator.pushReplacementNamed(context, Routes.signin),
              child: const Text('Ir para login'),
            ),
          ],
        ),
      ),
    );
  }
}
