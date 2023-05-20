import 'package:estacao_pilhas/pages/qr_code_reader/qr_code_reader.dart';
import 'package:flutter/material.dart';

import 'globals/colors.dart';

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
