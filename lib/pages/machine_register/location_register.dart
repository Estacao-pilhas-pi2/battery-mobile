import 'package:estacao_pilhas/components/base_form.dart';
import 'package:estacao_pilhas/components/rounded_button.dart';
import 'package:estacao_pilhas/components/text_field.dart';
import 'package:estacao_pilhas/pages/machine_register/values_register.dart';
import 'package:estacao_pilhas/utils/input_masks.dart';
import 'package:flutter/material.dart';

class LocationRegister extends StatefulWidget {
  const LocationRegister({Key? key, required this.machineId}) : super(key: key);

  final int machineId;

  @override
  _LocationRegisterState createState() => _LocationRegisterState();
}

class _LocationRegisterState extends State<LocationRegister> {
  String? _cep;
  String? _rua;
  String? _bairro;
  int? _numero;
  String? _complemento;
  String? _cidade;
  String? _estado;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BaseForm(
        appBarText: "Registrar Máquina",
        children: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                const SizedBox(height: 10),
                CustomTextField(
                  label: "CEP",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [Masks().maskCep],
                  onSave: (String? value) {
                    _cep = value;
                  },
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  label: "Rua",
                  notEmpty: true,
                  onSave: (String? value) {
                    _rua = value;
                  },
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  label: "Bairro",
                  notEmpty: true,
                  onSave: (String? value) {
                    _bairro = value;
                  },
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  label: "Número",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _numero = int.parse(value);
                  },
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  label: "Complemento",
                  onSave: (String? value) {
                    _complemento = value;
                  },
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  label: "Cidade",
                  notEmpty: true,
                  onSave: (String? value) {
                    _cidade = value;
                  },
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  label: "Estado",
                  notEmpty: true,
                  onSave: (String? value) {
                    _estado = value;
                  },
                ),
                const SizedBox(height: 50),
                RoundedButton(
                  onPressed: submit,
                  text: "Próximo",
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit() async {
    if (!_formKey.currentState!.validate()) {
      return null;
    }
    _formKey.currentState!.save();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext qrCodeContext) {
          return ValuesRegister(
              machineId: widget.machineId,
              cep: _cep,
              rua: _rua,
              bairro: _bairro,
              numero: _numero,
              complemento: _complemento,
              cidade: _cidade,
              estado: _estado);
        },
      ),
    );
  }
}
