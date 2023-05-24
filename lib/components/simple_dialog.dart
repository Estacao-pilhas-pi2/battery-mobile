import 'package:flutter/material.dart';

class BasicDialog extends StatelessWidget {
  final String title;
  final String message;
  const BasicDialog({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      title: Center(child: Text(title)),
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
