import 'package:flutter/material.dart';

import 'globals/colors.dart';
import 'pages/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Estação Pilhas',
        theme: AppColors.appTheme,
        home: const Login());
  }
}
