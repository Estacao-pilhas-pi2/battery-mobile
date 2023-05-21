import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final label;
  final keyboardType;
  final maxLength;
  final inputFormatters;
  final validator;
  final notEmpty;
  final minLength;
  final format;
  final onSave;

  const CustomTextField(
      {super.key,
      this.label,
      this.keyboardType,
      this.maxLength,
      this.inputFormatters,
      this.validator,
      this.notEmpty = false,
      this.minLength,
      this.format,
      this.onSave});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      onSaved: (String? value) {
        if (value != null) {
          widget.onSave(value);
        }
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(widget.label),
      ),
      validator: widget.validator ??
          (String? value) {
            if (value != null) {
              if (widget.notEmpty && value.isEmpty) {
                return "Campo \"${widget.label}\" deve ser preenchido";
              }

              if (widget.minLength != null &&
                  value.characters.length < widget.minLength) {
                return "Tamanho do campo ${widget.label} inválido";
              }

              if (widget.format != null) {
                RegExp regexp = RegExp(widget.format);
                bool itMatches = regexp.hasMatch(value);

                if (!itMatches) {
                  return "Preencha o campo ${widget.label} corretamente";
                }
              }
            }

            return null;
          },
    );
  }
}
