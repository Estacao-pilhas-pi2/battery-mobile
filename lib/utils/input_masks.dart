import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Masks {
  final maskCep = MaskTextInputFormatter(
    mask: "##.###-###",
    filter: {"#": RegExp(r'[0-9]')},
  );

  String? clearMask(String? string) {
    String newString = string!.replaceAll(RegExp(r'[\s\.\-\(\)]+'), '');

    return newString;
  }
}
