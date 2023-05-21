import 'package:estacao_pilhas/components/base_form.dart';
import 'package:estacao_pilhas/components/rounded_button.dart';
import 'package:estacao_pilhas/components/text_field.dart';
import 'package:flutter/material.dart';

class ValuesRegister extends StatefulWidget {
  const ValuesRegister(
      {Key? key,
      required this.machineId,
      required this.cep,
      required this.rua,
      required this.bairro,
      required this.numero,
      required this.complemento,
      required this.cidade,
      required this.estado})
      : super(key: key);

  final int machineId;
  final String? cep;
  final String? rua;
  final String? bairro;
  final int? numero;
  final String? complemento;
  final String? cidade;
  final String? estado;

  @override
  _ValuesRegisterState createState() => _ValuesRegisterState();
}

class _ValuesRegisterState extends State<ValuesRegister> {
  int? _9v;
  int? _AAA;
  int? _AA;
  int? _C;
  int? _D;
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
                CustomTextField(
                  label: "Créditos por pilha 9V",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _9v = int.parse(value);
                  },
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  label: "Créditos por pilha AAA",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _AAA = int.parse(value);
                  },
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  label: "Créditos por pilha AA",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _AA = int.parse(value);
                  },
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  label: "Créditos por pilha C",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _C = int.parse(value);
                  },
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  label: "Créditos por pilha D",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _D = int.parse(value);
                  },
                ),
                const SizedBox(height: 50),
                RoundedButton(
                  onPressed: submit,
                  text: "Registrar",
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

    debugPrint('cep : ${widget.cep}');
    debugPrint('rua : ${widget.rua}');
    debugPrint('bairro : ${widget.bairro}');
    debugPrint('número : ${widget.numero}');
    debugPrint('complemento : ${widget.complemento}');
    debugPrint('cidade : ${widget.cidade}');
    debugPrint('estado : ${widget.estado}');
    debugPrint('9V : $_9v');
    debugPrint('AAA : $_AAA');
    debugPrint('AA : $_AA');
    debugPrint('C : $_C');
    debugPrint('D : $_D');
  }
}
