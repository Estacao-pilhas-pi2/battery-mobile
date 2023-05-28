import 'package:estacao_pilhas/services/maquina_service.dart';
import 'package:flutter/material.dart';

import '../../../models/maquina.dart';

class MachineFormController {
  Future createMachine(int id, Maquina maquina) async {
    try {
      debugPrint("Creating machine: [${maquina.toJson()}]");
      Maquina createdMaquina =
          await MaquinaService().createMaquina(id, maquina);

      debugPrint("Machine created successfully: [${createdMaquina.toJson()}]");
      return createdMaquina;
    } catch (error) {
      debugPrint("Error while creating machine: [${error.toString()}]");
      return error.toString();
    }
  }
}
