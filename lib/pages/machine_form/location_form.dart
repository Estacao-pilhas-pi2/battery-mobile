import 'package:estacao_pilhas/components/base_form.dart';
import 'package:estacao_pilhas/components/rounded_button.dart';
import 'package:estacao_pilhas/components/text_field.dart';
import 'package:estacao_pilhas/models/maquina.dart';
import 'package:estacao_pilhas/models/usuario.dart';
import 'package:estacao_pilhas/pages/machine_form/values_form.dart';
import 'package:estacao_pilhas/services/usuario_service.dart';
import 'package:estacao_pilhas/utils/geolocator.dart';
import 'package:estacao_pilhas/utils/input_masks.dart';
import 'package:estacao_pilhas/pages/machine_management/controllers/machine_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationForm extends StatefulWidget {
  final int machineId;
  final int userId;
  final Maquina? maquina;

  const LocationForm(
      {Key? key, required this.machineId, required this.userId, this.maquina})
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
  Position? _localizacao;
  bool locationAltered = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Usuario user = Usuario();

  @override
  void initState() {
    super.initState();
    initialData();
  }

  void initialData() async {
    if (widget.maquina != null) {
      _cep = widget.maquina?.endereco?.cep;
      _bairro = widget.maquina?.endereco?.bairro;
      _cidade = widget.maquina?.endereco?.cidade;
      _estado = widget.maquina?.endereco?.estado;
      _numero = widget.maquina?.endereco?.numero;
      _complemento = widget.maquina?.endereco?.complemento;
      _rua = widget.maquina?.endereco?.rua;
    }
    user = await UsuarioService().getUserInfo();
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
                showMapPositionButton(),
                CustomTextField(
                  initialValue: widget.maquina?.endereco?.cep ?? "",
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
                  initialValue: widget.maquina?.endereco?.bairro ?? "",
                  label: "Bairro",
                  notEmpty: true,
                  onSave: (String? value) {
                    _bairro = value;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.maquina?.endereco?.rua ?? "",
                  label: "Rua",
                  notEmpty: true,
                  onSave: (String? value) {
                    _rua = value;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue:
                      widget.maquina?.endereco?.numero.toString() ?? "",
                  label: "Número",
                  notEmpty: true,
                  keyboardType: TextInputType.number,
                  onSave: (String value) {
                    _numero = int.parse(value);
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.maquina?.endereco?.complemento ?? "",
                  notEmpty: true,
                  label: "Complemento",
                  onSave: (String? value) {
                    _complemento = value;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.maquina?.endereco?.cidade ?? "",
                  label: "Cidade",
                  notEmpty: true,
                  onSave: (String? value) {
                    _cidade = value;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  initialValue: widget.maquina?.endereco?.estado ?? "",
                  label: "Estado",
                  maxLength: 2,
                  notEmpty: true,
                  onSave: (String? value) {
                    _estado = value;
                  },
                ),
                const SizedBox(height: 25),
                RoundedButton(
                  onPressed: submit,
                  text: widget.maquina != null ? "Salvar" : "Próximo",
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showMapPositionButton() {
    if (widget.maquina?.endereco != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: RoundedButton(
          text: "Alterar posição no mapa",
          onPressed: () async {
            locationAltered = true;
            _localizacao = await getUserPosition();
          },
        ),
      );
    }

    return const SizedBox(
      height: 25,
    );
  }

  void submit() async {
    if (!_formKey.currentState!.validate()) {
      return null;
    }
    _formKey.currentState!.save();

    if (widget.maquina == null) {
      _localizacao = await getUserPosition();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext qrCodeContext) {
            return ValuesForm(
                machineId: widget.machineId,
                userId: int.parse(user.identificador!),
                bairro: _bairro,
                cep: Masks().clearMask(_cep),
                cidade: _cidade,
                complemento: _complemento,
                estado: _estado,
                rua: _rua,
                numero: _numero,
                localizacao: _localizacao);
          },
        ),
      );
    } else {
      Map<String, dynamic> location = {
        "endereco": {
          "cep": Masks().clearMask(_cep),
          "estado": _estado,
          "cidade": _cidade,
          "bairro": _bairro,
          "rua": _rua,
          "numero": _numero,
          "complemento": _complemento,
          "latitude": widget.maquina?.endereco?.latitude,
          "longitude": widget.maquina?.endereco?.longitude,
        }
      };
      if (locationAltered) {
        location["endereco"]["latitude"] = _localizacao!.latitude;
        location["endereco"]["longitude"] = _localizacao!.longitude;
      }

      await MachineManagementController()
          .editMachine(widget.machineId, location);
      //debugPrint("TO-DO: Integrar com endpoint de patch");
      Navigator.of(context).pop();
    }
  }
}
