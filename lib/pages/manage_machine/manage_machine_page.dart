import 'dart:developer';

import 'package:estacao_pilhas/globals/colors.dart';
import 'package:estacao_pilhas/models/maquina.dart';
import 'package:estacao_pilhas/pages/machine_form/location_form.dart';
import 'package:estacao_pilhas/pages/manage_machine/controllers/manage_machine_page_controller.dart';
import 'package:flutter/material.dart';

import '../../components/rounded_button.dart';
import '../machine_form/values_form.dart';
import 'components/battery_storage.dart';

class ManageMachine extends StatefulWidget {
  final int machineId;

  const ManageMachine({super.key, required this.machineId});

  @override
  State<ManageMachine> createState() => _ManageMachineState();
}

class _ManageMachineState extends State<ManageMachine> {
  late Maquina machine;
  bool isNotificationEnabled = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initialRequest();
  }

  void initialRequest() async {
    Maquina requestedMachine =
        await ManageMachineController().getMachineInfo(widget.machineId);

    setState(() {
      machine = requestedMachine;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gerenciar Máquina"),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(children: [
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: BatteryStorage(machine: machine),
                ),
                const SizedBox(height: 30),
                RoundedButton(
                  text: "Editar Localização",
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LocationForm(
                            machineId: machine.id!,
                            maquina: machine,
                          ))),
                  fixedSize: const Size(165, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  backgroundColor: StaticColors.onPrimary,
                ),
                const SizedBox(height: 30),
                RoundedButton(
                  text: "Editar Créditos",
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ValuesForm(maquina: machine))),
                  fixedSize: const Size(165, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  backgroundColor: StaticColors.onPrimary,
                ),
                const SizedBox(height: 30),
                RoundedButton(
                  text: "Esvaziar Máquina",
                  fixedSize: const Size(165, 40),
                  onPressed: () => log("Esvaziar"),
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  backgroundColor: StaticColors.onPrimary,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Notificar sobre capacidade",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Switch(
                        value: isNotificationEnabled,
                        onChanged: (value) {
                          setState(() {
                            isNotificationEnabled = value;
                          });
                        },
                        activeColor: StaticColors.primary,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: ElevatedButton(
                    onPressed: () => log("Excluir"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: StaticColors.onPrimary,
                      fixedSize: const Size(91, 40),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 0.8),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    child: Text(
                      "Excluir",
                      style: TextStyle(
                        color: StaticColors.tertiary,
                      ),
                    ),
                  ),
                ),
              ]),
      ),
    );
  }
}
