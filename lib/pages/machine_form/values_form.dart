import 'package:estacao_pilhas/components/base_form.dart';
import 'package:estacao_pilhas/components/rounded_button.dart';
import 'package:estacao_pilhas/components/text_field.dart';
import 'package:estacao_pilhas/models/maquina.dart';
import 'package:flutter/material.dart';

class ValuesForm extends StatefulWidget {
  const ValuesForm(
      {Key? key,
      this.machineId,
      this.cep,
      this.descricao,
      this.bairro,
      this.numero,
      this.complemento,
      this.cidade,
      this.estado,
      this.maquina})
      : super(key: key);

  final int? machineId;
  final String? cep;
  final String? descricao;
  final String? bairro;
  final int? numero;
  final String? complemento;
  final String? cidade;
  final String? estado;
  final Maquina? maquina;

  @override
  State<ValuesForm> createState() => _ValuesFormState();
}

class _ValuesFormState extends State<ValuesForm> {
  int? _9v;
  int? _AAA;
  int? _AA;
  int? _C;
  int? _D;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void initialData() {
    if (widget.maquina != null) {
      _9v = widget.maquina?.precos[0].creditos;
      _AAA = widget.maquina?.precos[1].creditos;
      _AA = widget.maquina?.precos[2].creditos;
      _C = widget.maquina?.precos[3].creditos;
      _D = widget.maquina?.precos[4].creditos;
    }
  }

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
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue:
                      widget.maquina?.precos[0].creditos.toString() ?? "",
                  label: "Créditos por pilha 9V",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _9v = int.parse(value);
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue:
                      widget.maquina?.precos[1].creditos.toString() ?? "",
                  label: "Créditos por pilha AAA",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _AAA = int.parse(value);
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue:
                      widget.maquina?.precos[2].creditos.toString() ?? "",
                  label: "Créditos por pilha AA",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _AA = int.parse(value);
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue:
                      widget.maquina?.precos[3].creditos.toString() ?? "",
                  label: "Créditos por pilha C",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _C = int.parse(value);
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue:
                      widget.maquina?.precos[4].creditos.toString() ?? "",
                  label: "Créditos por pilha D",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _D = int.parse(value);
                  },
                ),
                const SizedBox(height: 25),
                RoundedButton(
                  onPressed: submit,
                  text: widget.maquina != null ? "Salvar" : "Registrar",
                ),
                const SizedBox(height: 10),
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

    if (widget.maquina != null) {
      Navigator.of(context).pop();
      return;
    }

    debugPrint('cep : ${widget.cep}');
    debugPrint('descricao : ${widget.descricao}');
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
