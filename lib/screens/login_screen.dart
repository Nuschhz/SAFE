import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glp/components/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeBrightness = Brightness.dark == Theme.of(context).brightness;
    final deviceSize = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    const sideSpacing = 0.45;

    return Scaffold(
      backgroundColor: theme.surface,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              width: deviceSize.width * (1 - sideSpacing),
              themeBrightness
                  ? 'assets/images/logo_light.svg'
                  : 'assets/images/logo_dark.svg',
            ),
            SizedBox(width: deviceSize.width * 0.8, child: const LoginForm()),
          ],
        ),
      ),
    );
  }
}
