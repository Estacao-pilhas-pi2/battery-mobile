import 'package:flutter/material.dart';

class DialogInfoText extends StatelessWidget {
  final String text;
  final IconData icon;

  const DialogInfoText(this.icon, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Flexible(child: Text(text))
        ],
      ),
    );
  }
}
