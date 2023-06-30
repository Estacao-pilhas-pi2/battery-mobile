import 'package:estacao_pilhas/globals/colors.dart';
import 'package:estacao_pilhas/models/maquina.dart';
import 'package:flutter/material.dart';

class MachineCard extends StatelessWidget {
  const MachineCard(
      {super.key,
      required this.userId,
      required this.machine,
      required this.onTap});
  final int userId;
  final Maquina machine;
  final Function(int, Maquina) onTap;

  IconData getBatteryIcon(currentValue) {
    if (currentValue == 0) {
      return Icons.battery_0_bar_rounded;
    } else if (currentValue < 15) {
      return Icons.battery_1_bar_rounded;
    } else if (currentValue < 35) {
      return Icons.battery_2_bar_rounded;
    } else if (currentValue < 55) {
      return Icons.battery_3_bar_rounded;
    } else if (currentValue < 75) {
      return Icons.battery_4_bar_rounded;
    } else if (currentValue < 90) {
      return Icons.battery_5_bar_rounded;
    } else if (currentValue < 120) {
      return Icons.battery_6_bar_rounded;
    }
    return Icons.battery_alert_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(
        getBatteryIcon(machine.getCurrentBatteries()),
        size: 50,
        color: StaticColors.onSecondary,
      ),
      title: Text('Máquina: ${machine.id}'),
      subtitle: Text(machine.endereco.toString()),
      isThreeLine: true,
      tileColor: StaticColors.secondary,
      trailing: Text('${machine.getCurrentBatteries()}/185'),
      onTap: () {
        onTap(userId, machine);
      },
    ));
  }
}
