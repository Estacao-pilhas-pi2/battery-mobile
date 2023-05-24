import 'package:estacao_pilhas/globals/colors.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Size? fixedSize;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  const RoundedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.fixedSize,
      this.padding,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? StaticColors.primary,
          fixedSize: fixedSize ?? const Size(216, 58),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: backgroundColor == StaticColors.onPrimary
                  ? StaticColors.primary
                  : StaticColors.onPrimary),
        ),
      ),
    );
  }
}
