import 'dart:io';

import 'package:estacao_pilhas/models/maquina.dart';
import 'package:estacao_pilhas/services/maquina_service.dart';

import '../../../models/usuario.dart';
import '../../../services/usuario_service.dart';

// Future<void> getUserInfo() {}
class EstablishmentPageController {
  Future<List<Maquina>> getMachines() async {
    sleep(const Duration(seconds: 5));
    List<Maquina> maquinaList = await MaquinaService().getMaquinaList();

    return maquinaList;
  }

  Future<Usuario> getUserInfo() async {
    return await UsuarioService().getUserInfo();
  }
}
