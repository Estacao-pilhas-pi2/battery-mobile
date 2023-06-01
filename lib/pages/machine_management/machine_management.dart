import 'package:estacao_pilhas/components/base_form.dart';
import 'package:estacao_pilhas/components/rounded_button.dart';
import 'package:estacao_pilhas/globals/colors.dart';
import 'package:estacao_pilhas/models/maquina.dart';
import 'package:estacao_pilhas/pages/machine_form/location_form.dart';
import 'package:estacao_pilhas/pages/machine_form/values_form.dart';
import 'package:estacao_pilhas/pages/machine_management/controllers/machine_management_controller.dart';
import 'package:flutter/material.dart';

class MachineManagement extends StatefulWidget {
  const MachineManagement(
      {super.key, required this.machine, required this.userId});
  final int userId;
  final Maquina machine;

  @override
  State<MachineManagement> createState() => _MachineManagementState();
}

class _MachineManagementState extends State<MachineManagement> {
  bool isNotification = true;
  double? notificationValue;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return BaseForm(
      appBarText: "Gerenciar Máquina",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
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
                    border: Border.all(width: 2, color: StaticColors.primary),
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
                              Text('AAA: ${widget.machine.quantidadeAAA}/100'),
                              Text('AA: ${widget.machine.quantidadeAA}/100'),
                              Text('C: ${widget.machine.quantidadeC}/100'),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('9V: ${widget.machine.quantidadeV9}/100'),
                              Text('D: ${widget.machine.quantidadeD}/100'),
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
                    border: Border.all(width: 2, color: StaticColors.primary),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Capacidade",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    userId: widget.userId,
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
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Notificar sobre capacidade"),
                Switch(
                  value: isNotification,
                  activeColor: StaticColors.primary,
                  onChanged: (bool value) {
                    setState(() {
                      isNotification = value;
                    });
                  },
                )
              ],
            ),
            showNotificationSlider(),
            const SizedBox(
              height: 25,
            ),
            RoundedButton(
              text: "Salvar",
              onPressed: () {
                debugPrint("TO-DO: Integrar com endpoint de patch");
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              height: 25,
            ),
            RoundedButton(
                text: "Excluir",
                backgroundColor: StaticColors.onPrimary,
                onPressed: () {
                  deleteMachine();
                  Navigator.of(context).pop();
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
    await MachineManagementController().emptyMachine(id);
  }

  showNotificationSlider() {
    if (isNotification) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
            value: notificationValue ?? widget.machine.limiteMaximo!.toDouble(),
            max: 100,
            onChanged: (double value) {
              setState(() {
                notificationValue = value;
              });
            },
          ),
          Text(
              '${notificationValue == null ? widget.machine.limiteMaximo!.toString() : notificationValue?.round().toString()}%')
        ],
      );
    }

    return const SizedBox(
      height: 48,
    );
  }
}
