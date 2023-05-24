import 'dart:io';

import 'package:estacao_pilhas/models/pilha.dart';

import '../../../models/endereco.dart';
import '../../../models/maquina.dart';

class ManageMachineController {
  Future<Maquina> getMachineInfo(int machineId) async {
    sleep(const Duration(seconds: 5));

    Maquina requestedMaquina = Maquina(
        "Maquina 1",
        1,
        [
          const Pilha(nome: "9V", quantidade: 1),
          const Pilha(nome: "AAA", quantidade: 2),
          const Pilha(nome: "AA", quantidade: 3),
          const Pilha(nome: "C", quantidade: 4),
          const Pilha(nome: "D", quantidade: 5)
        ],
        [
          const Pilha(nome: "9V", creditos: 1),
          const Pilha(nome: "AAA", creditos: 2),
          const Pilha(nome: "AA", creditos: 3),
          const Pilha(nome: "C", creditos: 4),
          const Pilha(nome: "D", creditos: 5)
        ],
        Endereco("cep", "bairro", "cidade", "estado", 5, "complemento",
            "descricao", -15.8014, -47.8823));

    return requestedMaquina;
  }
}
