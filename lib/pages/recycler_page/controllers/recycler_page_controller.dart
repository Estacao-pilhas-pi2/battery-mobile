import 'dart:io';

import 'package:estacao_pilhas/models/maquina.dart';
import 'package:estacao_pilhas/models/usuario.dart';
import 'package:estacao_pilhas/services/maquina_service.dart';
import 'package:estacao_pilhas/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../components/station_info_dialog.dart';

class RecyclerPageController {
  Future<Usuario> getUserInfo() async {
    return await UsuarioService().getUserInfo();
  }

  Future<List<Marker>> getStations() async {
    sleep(const Duration(seconds: 5));
    List<Maquina> maquinaList = await MaquinaService().getMaquinaList();
    List<Marker> markerList = [];

    for (Maquina maquina in maquinaList) {
      markerList.add(
        Marker(
          point:
              LatLng(maquina.endereco!.latitude!, maquina.endereco!.longitude!),
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
