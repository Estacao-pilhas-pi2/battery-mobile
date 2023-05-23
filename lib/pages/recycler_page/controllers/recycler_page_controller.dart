import 'dart:io';

import 'package:estacao_pilhas/models/maquina.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../models/endereco.dart';
import '../../../models/pilha.dart';
import '../components/station_info_dialog.dart';

// Future<void> getUserInfo() {}
class RecyclerPageController {
  Future<List<Marker>> getStations() async {
    sleep(const Duration(seconds: 5));
    List<Maquina> maquinaList = [
      Maquina(
          "Maquina 1",
          1,
          [
            Pilha("9V", 1),
            Pilha("AAA", 2),
            Pilha("AA", 3),
            Pilha("C", 4),
            Pilha("D", 5)
          ],
          [
            Pilha("9V", 1),
            Pilha("AAA", 2),
            Pilha("AA", 3),
            Pilha("C", 4),
            Pilha("D", 5)
          ],
          Endereco("cep", "bairro", "cidade", "estado", 5, "complemento",
              "descricao", -15.8014, -47.8823)),
      Maquina(
          "descricao",
          2,
          [
            Pilha("9V", 5),
            Pilha("AAA", 4),
            Pilha("AA", 3),
            Pilha("C", 2),
            Pilha("D", 1)
          ],
          [
            Pilha("9V", 5),
            Pilha("AAA", 4),
            Pilha("AA", 3),
            Pilha("C", 2),
            Pilha("D", 1)
          ],
          Endereco("cep", "bairro", "cidade", "estado", 5, "complemento",
              "descricao", -15.7996, -47.8823))
    ];
    List<Marker> markerList = [];

    for (Maquina maquina in maquinaList) {
      markerList.add(
        Marker(
          point: LatLng(maquina.endereco.latitude, maquina.endereco.longitude),
          width: 35,
          height: 35,
          builder: (context) => IconButton(
              onPressed: () => _showStationInfoDialog(maquina, context),
              icon: const Icon(
                Icons.location_on,
                size: 35,
              )),
        ),
      );
    }

    return markerList;
  }

  Future<void> _showStationInfoDialog(
      Maquina station, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StationInfoDialog(station);
      },
    );
  }
}
