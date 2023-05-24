import 'package:estacao_pilhas/globals/colors.dart';
import 'package:estacao_pilhas/pages/recycler_page/recycler_page.dart';
import 'package:flutter/material.dart';

class CreditsReceived extends StatefulWidget {
  final String paymentId;
  const CreditsReceived({super.key, required this.paymentId});

  @override
  State<CreditsReceived> createState() => _CreditsReceivedState();
}

class _CreditsReceivedState extends State<CreditsReceived> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Créditos Recebidos"),
        ),
        body: ListView(children: [
          const SizedBox(height: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Transação concluída",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
              Icon(
                Icons.download_done,
                color: StaticColors.primary,
                size: 180,
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Container(
                  width: deviceSize.width,
                  decoration: BoxDecoration(
                      color: StaticColors.background,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(color: StaticColors.primary),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Informações gerais",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                      Divider(
                          height: 1,
                          color: StaticColors.primary,
                          thickness: 0.8),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: StaticColors.secondary,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.battery_std,
                                        color: StaticColors.primary,
                                      ),
                                      const SizedBox(width: 15),
                                      const Text(
                                        "10 Pilhas",
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Icon(
                                    Icons.keyboard_double_arrow_down,
                                    color: StaticColors.primary,
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.credit_card,
                                        color: StaticColors.primary,
                                      ),
                                      const SizedBox(width: 15),
                                      const Text(
                                        "5 Créditos",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const RecyclerPage()),
                      (Route<dynamic> route) => false),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(216, 58),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  child: const Text(
                    "Voltar ao inicio",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
