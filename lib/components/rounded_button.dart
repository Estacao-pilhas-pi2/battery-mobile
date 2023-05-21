import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final text;
  final onPressed;
  const RoundedButton({super.key, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(216, 58),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Text(text),
    );
  }
}
