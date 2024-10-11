import 'package:flutter/material.dart';
import 'package:glp/routes/app_routes.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _codeController = TextEditingController();
  final String token = '70D032AX';

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _validateAndNavigate(theme) {
    if (_codeController.text == token) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.menu);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Código de acesso incorreto!',
              style: TextStyle(color: theme.onPrimary)),
          backgroundColor: theme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      children: [
        const Text(
          'Trazendo segurança para você!',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _codeController,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: theme.onSecondary,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: "Insira seu código de acesso",
            hintStyle: TextStyle(color: theme.onSecondary),
            filled: true,
            fillColor: theme.secondary,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.onSecondaryFixed),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: theme.onSecondaryFixed),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.onSecondaryFixed,
                width: 0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: deviceSize.width * 0.8,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              backgroundColor: theme.primary,
              elevation: 0,
            ),
            onPressed: () => _validateAndNavigate(theme),
            child: Text(
              'Acessar',
              style: TextStyle(color: theme.onPrimary),
            ),
          ),
        ),
      ],
    );
  }
}
