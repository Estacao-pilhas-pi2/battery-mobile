import 'dart:io';

import '../../../models/endereco.dart';
import '../../../models/maquina.dart';

class ManageMachineController {
  Future<Maquina> getMachineInfo(int machineId) async {
    sleep(const Duration(seconds: 5));

    Maquina requestedMaquina = Maquina(
        id: 1,
        endereco: Endereco(
            cep: "12345678",
            estado: "SP",
            cidade: "São Paulo",
            bairro: "Centro",
            rua: "Avenida Principal",
            numero: 123,
            complemento: "Verde",
            latitude: -15.80040000,
            longitude: -47.88220000),
        descricao: "null",
        precoAAA: "0.00",
        precoAA: "0.00",
        precoC: "0.00",
        precoD: "0.00",
        precoV9: "0.00",
        quantidadeAAA: 0,
        quantidadeAA: 0,
        quantidadeC: 0,
        quantidadeD: 0,
        quantidadeV9: 0,
        limiteMaximo: "70.00",
        estabelecimento: 1);

    return requestedMaquina;
  }
}
