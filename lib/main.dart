import 'package:flutter/material.dart';
import 'package:glp/providers/theme_provider.dart';
import 'package:glp/routes/app_routes.dart';
import 'package:glp/screens/login_screen.dart';
import 'package:glp/screens/menu_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: Provider.of<ThemeProvider>(context).themeData,
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.home: (ctx) => const LoginScreen(),
          AppRoutes.menu: (ctx) => const MenuScreen(),
        });
  }
}
