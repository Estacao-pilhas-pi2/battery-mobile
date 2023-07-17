import 'dart:developer';

import 'package:estacao_pilhas/components/base_form.dart';
import 'package:estacao_pilhas/components/rounded_button.dart';
import 'package:estacao_pilhas/globals/colors.dart';
import 'package:estacao_pilhas/models/maquina.dart';
import 'package:estacao_pilhas/pages/establishment_page/establishment_page.dart';
import 'package:estacao_pilhas/pages/machine_form/location_form.dart';
import 'package:estacao_pilhas/pages/machine_form/values_form.dart';
import 'package:estacao_pilhas/pages/machine_management/controllers/machine_management_controller.dart';
import 'package:estacao_pilhas/pages/payment_history/payment_history.dart';
import 'package:estacao_pilhas/services/usuario_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../components/simple_dialog.dart';
import '../../models/usuario.dart';

class MachineManagement extends StatefulWidget {
  const MachineManagement(
      {super.key, required this.machine, required this.userId});
  final int userId;
  final Maquina machine;

  @override
  State<MachineManagement> createState() => _MachineManagementState();
}

class _MachineManagementState extends State<MachineManagement> {
  bool isLoading = true;
  bool isNotificationEnabled = false;
  double notificationValue = 0;
  Maquina maquina = Maquina();
  Usuario user = Usuario();

  @override
  void initState() {
    super.initState();

    initUser();
    machineRequest();
    notificationRequest();
  }

  initUser() async {
    user = await UsuarioService().getUserInfo();
  }

  Future<void> machineRequest() async {
    int id = widget.machine.id!;
    var maquinaResponse =
        await MachineManagementController().getMaquinaInfo(id);

    setState(() {
      isLoading = false;
      maquina = maquinaResponse;
    });
  }

  void notificationRequest() async {
    bool notificationStatus =
        await MachineManagementController().getNotificationStatus();
    setState(() {
      notificationValue = double.parse(widget.machine.limiteMaximo.toString());
      isNotificationEnabled = notificationStatus;
    });
  }

  void setNotification() async {
    bool requestNotificationPermissions = await MachineManagementController()
        .setNotification(isNotificationEnabled);

    if (requestNotificationPermissions) setNotificationValue();

    setState(() {
      isNotificationEnabled = requestNotificationPermissions;
    });
  }

  void setNotificationValue() async {
    final registrationId = await FirebaseMessaging.instance.getToken();

    MachineManagementController()
        .registerNotification(registrationId!, "android");
    Map<String, double> limit = {
      "limite_maximo": notificationValue.roundToDouble()
    };

    MachineManagementController().editMachine(widget.machine.id!, limit);
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return BaseForm(
      appBarText: "Gerenciar Máquina",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: deviceSize.width,
                        height: 105,
                        decoration: BoxDecoration(
                          color: StaticColors.secondary,
                          border:
                              Border.all(width: 2, color: StaticColors.primary),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('AAA: ${maquina.quantidadeAAA}/55'),
                                    Text('AA: ${maquina.quantidadeAA}/50'),
                                    Text('C: ${maquina.quantidadeC}/40'),
                                  ]),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('9V: ${maquina.quantidadeV9}/20'),
                                    Text('D: ${maquina.quantidadeD}/20'),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: deviceSize.width,
                        height: 25,
                        decoration: BoxDecoration(
                          color: StaticColors.onPrimary,
                          border:
                              Border.all(width: 2, color: StaticColors.primary),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Capacidade",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RoundedButton(
                    text: "Editar Localização",
                    backgroundColor: StaticColors.onPrimary,
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return LocationForm(
                          userId: widget.userId,
                          machineId: widget.machine.id!,
                          maquina: widget.machine,
                        );
                      }));
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RoundedButton(
                    text: "Editar Créditos",
                    backgroundColor: StaticColors.onPrimary,
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ValuesForm(
                          userId: int.parse(user.identificador!),
                          machineId: widget.machine.id,
                          maquina: widget.machine,
                        );
                      }));
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RoundedButton(
                    text: "Esvaziar Máquina",
                    backgroundColor: StaticColors.onPrimary,
                    onPressed: emptyMachine,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RoundedButton(
                    text: "Ver Histórico",
                    backgroundColor: StaticColors.onPrimary,
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return PaymentHistoryPage(maquinaId: widget.machine.id);
                      }));
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Notificar sobre capacidade"),
                      Switch(
                        value: isNotificationEnabled,
                        activeColor: StaticColors.primary,
                        onChanged: (bool value) {
                          setNotification();
                        },
                      )
                    ],
                  ),
                  showNotificationSlider(),
                  const SizedBox(
                    height: 25,
                  ),
                  RoundedButton(
                      text: "Excluir",
                      backgroundColor: StaticColors.onPrimary,
                      onPressed: () {
                        deleteMachine();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => EstablishmentPage(
                                      userId: int.parse(user.id!),
                                    )),
                            (Route<dynamic> route) => false);
                      }),
                ],
              ),
      ),
    );
  }

  void deleteMachine() async {
    Map<String, void> delete = {"estabelecimento": null};
    await MachineManagementController().editMachine(widget.machine.id!, delete);
  }

  void emptyMachine() async {
    Map<String, int> id = {"id": widget.machine.id!};
    bool emptyMachineResponse =
        await MachineManagementController().emptyMachine(id);
    log(emptyMachineResponse.toString());

    if (emptyMachineResponse) {
      await machineRequest();
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return BasicDialog(
              title: 'Máquina Esvaziada',
              message: "Máquina esvaziada com sucesso");
        },
      );
    }
  }

  showNotificationSlider() {
    if (isNotificationEnabled) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
            value: notificationValue,
            max: 100,
            onChangeEnd: (value) {
              setNotificationValue();
            },
            onChanged: (double value) {
              setState(() {
                notificationValue = value;
              });
            },
          ),
          Text('${notificationValue.round().toString()}%')
        ],
      );
    }

    return const SizedBox(
      height: 48,
    );
  }
}
