import 'dart:io';

import 'package:estacao_pilhas/models/maquina.dart';

import '../../../models/endereco.dart';

// Future<void> getUserInfo() {}
class EstablishmentPageController {
  Future<List<Maquina>> getMachines() async {
    sleep(const Duration(seconds: 5));
    List<Maquina> maquinaList = [
      Maquina(
          "Maquina 1",
          1,
          Endereco("12345-678", "rua", "bairro", "cidade", "estado", 5,
              "complemento", "descricao", -15.8014, -47.8823),
          1,
          2,
          3,
          4,
          5,
          1,
          2,
          3,
          4,
          5),
      Maquina(
          "descricao",
          2,
          Endereco("cep", "rua", "bairro", "cidade", "estado", 5, "complemento",
              "descricao", -15.7996, -47.8823),
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
          10),
      Maquina(
          "descricao",
          3,
          Endereco("cep", "rua", "bairro", "cidade", "estado", 5, "complemento",
              "descricao", -15.7996, -47.8823),
          1,
          2,
          3,
          4,
          5,
          11,
          12,
          13,
          14,
          15),
      Maquina(
          "descricao",
          4,
          Endereco("cep", "rua", "bairro", "cidade", "estado", 5, "complemento",
              "descricao", -15.7996, -47.8823),
          1,
          2,
          3,
          4,
          5,
          20,
          20,
          20,
          20,
          20)
    ];

    return maquinaList;
  }
}
