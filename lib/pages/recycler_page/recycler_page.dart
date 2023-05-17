import 'dart:developer';

import 'package:estacao_pilhas/globals/colors.dart';
import 'package:estacao_pilhas/models/endereco.dart';
import 'package:estacao_pilhas/models/maquina.dart';
import 'package:estacao_pilhas/models/pilha.dart';
import 'package:estacao_pilhas/pages/recycler_page/components/station_info_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RecyclerPage extends StatefulWidget {
  const RecyclerPage({super.key});

  @override
  State<RecyclerPage> createState() => _RecyclerPageState();
}

class _RecyclerPageState extends State<RecyclerPage> {
  late String username;
  late int credits;
  final MapController _mapController = MapController();
  List<Marker> markerList = [];

  @override
  void initState() {
    super.initState();

    initialRequest();
  }

  // TODO: Função que chama os requests do backend
  Future<void> initialRequest() async {
    markerList = [
      Marker(
        point: LatLng(-15.807746, -47.879698),
        width: 60,
        height: 60,
        builder: (context) => const Icon(Icons.location_on),
      ),
      Marker(
        point: LatLng(-15.807646, -47.878698),
        width: 60,
        height: 60,
        builder: (context) => IconButton(
            onPressed: () => _showDialog(Maquina(
                "descricao",
                1,
                [
                  Pilha("9V", 5),
                  Pilha("AAA", 5),
                  Pilha("AA", 5),
                  Pilha("C", 5),
                  Pilha("D", 5)
                ],
                [
                  Pilha("9V", 5),
                  Pilha("AAA", 5),
                  Pilha("AA", 5),
                  Pilha("C", 5),
                  Pilha("D", 5)
                ],
                Endereco("cep", "bairro", "cidade", "estado", 5, "complemento",
                    "descricao"))),
            icon: const Icon(Icons.person_pin_circle)),
      ),
    ];
    username = "Usuário";
    credits = 20;
  }

  Future<void> _showDialog(Maquina station) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StationInfoDialog(station);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Estação Pilhas")),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              child: Text(
                "Bem vindo(a) $username",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Container(
                width: deviceSize.width,
                height: 70,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Créditos disponíveis",
                          style: TextStyle(
                              color: AppColors.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        const Spacer(),
                        Text(
                          "$credits Créditos",
                          style: TextStyle(
                              color: AppColors.onPrimary, fontSize: 18),
                        )
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: deviceSize.height * 0.5,
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                    center: LatLng(-15.807746, -47.879698), zoom: 16),
                nonRotatedChildren: [],
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  MarkerLayer(markers: markerList),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ElevatedButton(
                onPressed: () => log("Ler QR Code"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(216, 58),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                ),
                child: const Text(
                  "Ler QR Code",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
