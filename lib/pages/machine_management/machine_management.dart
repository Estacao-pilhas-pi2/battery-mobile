import 'package:estacao_pilhas/components/base_form.dart';
import 'package:estacao_pilhas/components/rounded_button.dart';
import 'package:estacao_pilhas/globals/colors.dart';
import 'package:estacao_pilhas/models/maquina.dart';
import 'package:flutter/material.dart';

class MachineManagement extends StatefulWidget {
  const MachineManagement({super.key, required this.machine});
  final Maquina machine;

  @override
  State<MachineManagement> createState() => _MachineManagementState();
}

class _MachineManagementState extends State<MachineManagement> {
  bool isNotification = true;
  double notificationValue = 0;

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
                    padding: EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('AAA: ${widget.machine.quantidade_AAA}/100'),
                              Text('AA: ${widget.machine.quantidade_AA}/100'),
                              Text('C: ${widget.machine.quantidade_C}/100'),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('9V: ${widget.machine.quantidade_V9}/100'),
                              Text('D: ${widget.machine.quantidade_D}/100'),
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
              textColor: StaticColors.primary,
              onPressed: () {},
            ),
            const SizedBox(
              height: 25,
            ),
            RoundedButton(
              text: "Editar Créditos",
              backgroundColor: StaticColors.onPrimary,
              textColor: StaticColors.primary,
              onPressed: () {},
            ),
            const SizedBox(
              height: 25,
            ),
            RoundedButton(
              text: "Esvaziar Máquina",
              backgroundColor: StaticColors.onPrimary,
              textColor: StaticColors.primary,
              onPressed: () {},
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Notificar sobre capacidade"),
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
              onPressed: () {},
            ),
            const SizedBox(
              height: 25,
            ),
            RoundedButton(
              text: "Excluir",
              backgroundColor: StaticColors.onPrimary,
              textColor: StaticColors.primary,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  showNotificationSlider() {
    if (isNotification) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
            value: notificationValue,
            max: 100,
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
