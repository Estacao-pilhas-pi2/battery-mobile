import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      title: const Center(child: Text('Falha no login')),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(86, 40),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
          ),
          child: const Text(
            "Voltar",
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
