import 'package:acougue/routing/router.dart';
import 'package:acougue/ui/core/ui/logo_image.dart';
import 'package:flutter/material.dart';

import '/ui/features/splash/splash_view_model.dart';

class SplashPage extends StatefulWidget {
  final SplashViewModel splashViewModel;

  const SplashPage({super.key, required this.splashViewModel});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _scale = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        _scale = 1;
      });
    });

    widget.splashViewModel.load.addListener(_checkAutoLogin);
  }

  @override
  void dispose() {
    widget.splashViewModel.load.removeListener(_checkAutoLogin);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: _scale,
              curve: Curves.easeInCirc,
              duration: Duration(seconds: 1),
              child: LogoImage(radius: 125),
            ),
            // Text('Açougue Sabor da Morte'),
          ],
        ),
      ),
    );
  }

  void _checkAutoLogin() {
    final result = widget.splashViewModel.load.result;
    if (result == null) {
      Navigator.pushReplacementNamed(context, Routes.signin);
    }

    result?.fold(
      onSuccess: (_) {
        Navigator.pop(context);
      },
      onFailure: (_) {
        Navigator.pushReplacementNamed(context, Routes.signin);
      },
    );
  }
}
