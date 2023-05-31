import 'package:estacao_pilhas/components/base_form.dart';
import 'package:estacao_pilhas/components/rounded_button.dart';
import 'package:estacao_pilhas/components/text_field.dart';
import 'package:estacao_pilhas/models/endereco.dart';
import 'package:estacao_pilhas/models/maquina.dart';
import 'package:estacao_pilhas/pages/machine_form/controllers/machine_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ValuesForm extends StatefulWidget {
  const ValuesForm(
      {Key? key,
      required this.userId,
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
  final int userId;
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
                  initialValue: widget.maquina?.precoV9.toString() ?? "",
                  label: "Créditos por pilha 9V",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _9v = int.parse(value);
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.maquina?.precoAAA.toString() ?? "",
                  label: "Créditos por pilha AAA",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _AAA = int.parse(value);
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.maquina?.precoAA.toString() ?? "",
                  label: "Créditos por pilha AA",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _AA = int.parse(value);
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.maquina?.precoC.toString() ?? "",
                  label: "Créditos por pilha C",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _C = int.parse(value);
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.maquina?.precoD.toString() ?? "",
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

    if (widget.maquina == null) {
      Endereco endereco = Endereco(
          bairro: widget.bairro,
          cep: widget.cep,
          cidade: widget.cidade,
          complemento: widget.complemento,
          estado: widget.estado,
          numero: widget.numero,
          rua: widget.rua,
          latitude: widget.localizacao!.latitude,
          longitude: widget.localizacao!.longitude);
      Maquina maquina = Maquina(
          estabelecimento: widget.userId,
          endereco: endereco,
          precoAA: _AA,
          precoAAA: _AAA,
          precoC: _C,
          precoD: _D,
          precoV9: _9v,
          limiteMaximo: 100);

      await MachineFormController().createMachine(widget.machineId!, maquina);

      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      debugPrint("TO-DO: Integrar com endpoint de patch");
      Navigator.of(context).pop();
    }
  }
}
