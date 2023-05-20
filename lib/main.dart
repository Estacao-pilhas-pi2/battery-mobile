import 'package:estacao_pilhas/pages/qr_code_reader/qr_code_reader.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estação Pilhas',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(3, 140, 62, 1),
            onPrimary: const Color.fromRGBO(255, 255, 255, 1),
            secondary: const Color.fromRGBO(199, 228, 211, 1),
            background: const Color.fromRGBO(241, 241, 241, 1),
            tertiary: const Color.fromRGBO(88, 122, 166, 1),
            onSecondary: const Color.fromRGBO(0, 0, 0, 1),
          ),
          textTheme: const TextTheme(
            titleMedium: TextStyle(fontFamily: 'Inter'),
            titleLarge: TextStyle(fontFamily: 'Inter'),
            titleSmall: TextStyle(fontFamily: 'Inter'),
          ),
          fontFamily: 'Roboto'),
      home: QrCodeReader(
        displayText: "Leia o Código QR localizado na parte X da máquina",
        onRead: (capture) {
          if (capture['id'] != null) {
            debugPrint('Valor lido: $capture');
          } else {
            debugPrint('Valor errado');
          }
        },
      ),
    );
  }
}
