import 'package:estacao_pilhas/globals/colors.dart';
import 'package:flutter/material.dart';

import '../../../models/pilha.dart';

class BatteryStorage extends StatelessWidget {
  final List<Pilha> batteryList;

  const BatteryStorage({super.key, required this.batteryList});

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
                    "${batteryList[0].nome}: ${batteryList[0].quantidade}/100",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "${batteryList[1].nome}: ${batteryList[1].quantidade}/100",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "${batteryList[2].nome}: ${batteryList[2].quantidade}/100",
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
                      "${batteryList[3].nome}: ${batteryList[3].quantidade}/100",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "${batteryList[4].nome}: ${batteryList[4].quantidade}/100",
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
