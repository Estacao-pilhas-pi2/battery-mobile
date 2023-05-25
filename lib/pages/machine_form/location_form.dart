import 'dart:developer';

import 'package:estacao_pilhas/components/base_form.dart';
import 'package:estacao_pilhas/components/rounded_button.dart';
import 'package:estacao_pilhas/components/text_field.dart';
import 'package:estacao_pilhas/models/maquina.dart';
import 'package:estacao_pilhas/pages/machine_form/values_form.dart';
import 'package:estacao_pilhas/utils/input_masks.dart';
import 'package:flutter/material.dart';

class LocationForm extends StatefulWidget {
  final int machineId;
  final Maquina? machine;

  const LocationForm({Key? key, required this.machineId, this.machine})
      : super(key: key);

  @override
  State<LocationForm> createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
  String? _cep;
  String? _bairro;
  int? _numero;
  String? _complemento;
  String? _cidade;
  String? _estado;
  String? _rua;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initialData();
  }

  void initialData() async {
    if (widget.machine != null) {
      _cep = widget.machine?.endereco?.cep;
      _bairro = widget.machine?.endereco?.bairro;
      _cidade = widget.machine?.endereco?.cidade;
      _estado = widget.machine?.endereco?.estado;
      _numero = widget.machine?.endereco?.numero;
      _complemento = widget.machine?.endereco?.complemento;
      _rua = widget.machine?.endereco?.rua;
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
                RoundedButton(
                  onPressed: () => log("localização"),
                  text: "Pegar Localização atual",
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.machine?.endereco?.cep ?? "",
                  label: "CEP",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [Masks().maskCep],
                  onSave: (String? value) {
                    _cep = value;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.machine?.endereco?.bairro ?? "",
                  label: "Bairro",
                  notEmpty: true,
                  onSave: (String? value) {
                    _bairro = value;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.machine?.endereco?.rua ?? "",
                  label: "Rua",
                  notEmpty: true,
                  onSave: (String? value) {
                    _rua = value;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue:
                      widget.machine?.endereco?.numero.toString() ?? "",
                  label: "Número",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _numero = int.parse(value);
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.machine?.endereco?.complemento ?? "",
                  label: "Complemento",
                  onSave: (String? value) {
                    _complemento = value;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.machine?.endereco?.cidade ?? "",
                  label: "Cidade",
                  notEmpty: true,
                  onSave: (String? value) {
                    _cidade = value;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.machine?.endereco?.estado ?? "",
                  label: "Estado",
                  notEmpty: true,
                  onSave: (String? value) {
                    _estado = value;
                  },
                ),
                const SizedBox(height: 25),
                RoundedButton(
                  onPressed: submit,
                  text: widget.machine != null ? "Salvar" : "Próximo",
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

    if (widget.machine != null) {
      Navigator.of(context).pop();
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext qrCodeContext) {
          return ValuesForm(
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
