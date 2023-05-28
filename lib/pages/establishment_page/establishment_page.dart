import 'package:estacao_pilhas/components/machine_card.dart';
import 'package:estacao_pilhas/components/rounded_button.dart';
import 'package:estacao_pilhas/models/maquina.dart';
import 'package:estacao_pilhas/pages/establishment_page/controllers/establishment_page_controller.dart';
import 'package:estacao_pilhas/pages/machine_form/location_form.dart';
import 'package:estacao_pilhas/pages/qr_code_reader/qr_code_reader.dart';
import 'package:flutter/material.dart';

class EstablishmentPage extends StatefulWidget {
  const EstablishmentPage({super.key, required this.userId});
  final int userId;

  @override
  State<EstablishmentPage> createState() => _EstablishmentPageState();
}

class _EstablishmentPageState extends State<EstablishmentPage> {
  late String username = "";
  bool isScreenLoading = true;
  List<Maquina> machineList = [];

  Future<void> initialRequest() async {
    List<Maquina> requestedMachineList =
        await EstablishmentPageController().getMachines();

    setState(() {
      machineList = requestedMachineList;
      username = "Usuário";
      isScreenLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    initialRequest();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Estação Pilhas")),
        ),
        body: isScreenLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 28),
                        child: Text(
                          "Bem vindo(a) $username",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: RoundedButton(
                        text: "Registrar Máquina",
                        onPressed: navigateToAddMachine,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 25),
                      child: Text(
                        "Minhas Máquinas",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: machineList.length,
                        itemBuilder: (context, index) {
                          return MachineCard(
                              userId: widget.userId,
                              machine: machineList[index]);
                        },
                      ),
                    ),
                    const SizedBox(height: 40)
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> navigateToAddMachine() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return QrCodeReader(
          displayText: "Leia o Código QR localizado na parte X da máquina",
          onRead: (capture, qrCodeContext) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return LocationForm(
                  machineId: capture['id'], userId: widget.userId);
            }));
            return true;
          });
    }));

    initialRequest();
  }
}
