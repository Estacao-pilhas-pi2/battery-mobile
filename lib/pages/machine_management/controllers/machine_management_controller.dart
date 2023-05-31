//import 'dart:convert';

// import 'package:estacao_pilhas/globals/utils.dart';
//import 'package:estacao_pilhas/models/maquina.dart';
//import 'package:geolocator/geolocator.dart';

import '../../../services/maquina_service.dart';

class MachineManagementController {
  Future editMachine(int id, Map changes) async {
    try {
      await MaquinaService().editMaquina(id, changes);
      return true;
    } catch (error) {
      return error.toString();
    }
  }

  Future emptyMachine(Map id) async {
    try {
      await MaquinaService().emptyMaquina(id);
      return true;
    } catch (error) {
      return error.toString();
    }
  }
}
