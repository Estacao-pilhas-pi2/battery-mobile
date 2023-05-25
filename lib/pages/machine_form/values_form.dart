import 'package:estacao_pilhas/components/base_form.dart';
import 'package:estacao_pilhas/components/rounded_button.dart';
import 'package:estacao_pilhas/components/text_field.dart';
import 'package:estacao_pilhas/models/maquina.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ValuesForm extends StatefulWidget {
  const ValuesForm(
      {Key? key,
      this.machineId,
      this.cep,
      this.rua,
      this.bairro,
      this.numero,
      this.complemento,
      this.cidade,
      this.estado,
      this.localizacao,
      this.maquina})
      : super(key: key);

  final int? machineId;
  final String? cep;
  final String? rua;
  final String? bairro;
  final int? numero;
  final String? complemento;
  final String? cidade;
  final String? estado;
  final Position? localizacao;
  final Maquina? maquina;

  @override
  State<ValuesForm> createState() => _ValuesFormState();
}

class _ValuesFormState extends State<ValuesForm> {
  String? _9v;
  String? _AAA;
  String? _AA;
  String? _C;
  String? _D;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void initialData() {
    if (widget.maquina != null) {
      _9v = widget.maquina?.precoV9;
      _AAA = widget.maquina?.precoAAA;
      _AA = widget.maquina?.precoAA;
      _C = widget.maquina?.precoC;
      _D = widget.maquina?.precoD;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BaseForm(
        appBarText: "Registrar Máquina",
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.maquina?.precoV9 ?? "",
                  label: "Créditos por pilha 9V",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _9v = value;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.maquina?.precoAAA ?? "",
                  label: "Créditos por pilha AAA",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _AAA = value;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.maquina?.precoAA ?? "",
                  label: "Créditos por pilha AA",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _AA = value;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.maquina?.precoC ?? "",
                  label: "Créditos por pilha C",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _C = value;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.maquina?.precoD ?? "",
                  label: "Créditos por pilha D",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _D = value;
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

    if (widget.maquina == null) {
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
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      debugPrint("TO-DO: Integrar com endpoint de patch");
      Navigator.of(context).pop();
    }
  }
}
