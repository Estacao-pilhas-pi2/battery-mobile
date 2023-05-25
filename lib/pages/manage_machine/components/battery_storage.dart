import 'package:estacao_pilhas/globals/colors.dart';
import 'package:estacao_pilhas/models/maquina.dart';
import 'package:flutter/material.dart';

class BatteryStorage extends StatelessWidget {
  final Maquina machine;

  const BatteryStorage({super.key, required this.machine});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Container(
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
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Text(
              "Capacidade",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        Divider(height: 1, color: StaticColors.primary, thickness: 0.8),
        Container(
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
                Column(children: [
                  Text(
                    "9V: ${machine.quantidadeV9}/100",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "AAA: ${machine.quantidadeAAA}/100",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "AA: ${machine.quantidadeAA}/100",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                ]),
                SizedBox(
                  width: deviceSize.width * 0.2,
                ),
                Column(
                  children: [
                    Text(
                      "C: ${machine.quantidadeC}/100",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "D: ${machine.quantidadeD}/100",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
