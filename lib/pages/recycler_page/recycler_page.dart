import 'dart:developer';

import 'package:estacao_pilhas/globals/colors.dart';
import 'package:estacao_pilhas/models/endereco.dart';
import 'package:estacao_pilhas/models/maquina.dart';
import 'package:estacao_pilhas/models/pilha.dart';
import 'package:estacao_pilhas/pages/recycler_page/components/station_info_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'components/location_error_dialog.dart';

class RecyclerPage extends StatefulWidget {
  const RecyclerPage({super.key});

  @override
  State<RecyclerPage> createState() => _RecyclerPageState();
}

class _RecyclerPageState extends State<RecyclerPage> {
  late String username = "";
  late int credits = 5;
  final MapController _mapController = MapController();
  List<Marker> markerList = [];
  late Position userLocation = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);
  bool isScreenLoading = true;

  @override
  void initState() {
    super.initState();

    initialRequest();
    getUserPosition();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> getUserPosition() async {
    try {
      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

      if (!isLocationEnabled) {
        throw ("Para o correto funcionamento do aplicativo é necessário que sua localização esteja habilitada!");
      }

      LocationPermission locationPermission =
          await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.denied) {
          throw ("Para o correto funcionamento do aplicativo é necessário que sua localização esteja habilitada!");
        }
      }
      if (locationPermission == LocationPermission.deniedForever) {
        throw ("Acesse as configurações para habilitar a localização!");
      }

      userLocation = await Geolocator.getCurrentPosition();
    } catch (error) {
      _showLocationErrorDialog(error.toString());
    }

    setState(() {
      isScreenLoading = false;
    });
  }

  // TODO: Função que chama os requests do backend
  Future<void> initialRequest() async {
    markerList = [
      Marker(
        point: LatLng(-15.807646, -47.878698),
        width: 60,
        height: 60,
        builder: (context) => IconButton(
            onPressed: () => _showStationInfoDialog(Maquina(
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
            icon: const Icon(Icons.location_on)),
      ),
    ];
    username = "Usuário";
    credits = 20;
  }

  Future<void> _showStationInfoDialog(Maquina station) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StationInfoDialog(station);
      },
    );
  }

  Future<void> _showLocationErrorDialog(String error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return LocationErrorDialog(error);
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
        body: isScreenLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 28),
                      child: Text(
                        "Bem vindo(a) $username",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Container(
                      width: deviceSize.width,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
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
                          center: LatLng(
                              userLocation.latitude, userLocation.longitude),
                          zoom: 16),
                      nonRotatedChildren: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 15, bottom: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              child: IconButton(
                                  onPressed: () async {
                                    await getUserPosition();
                                    _mapController.move(
                                        LatLng(userLocation.latitude,
                                            userLocation.longitude),
                                        16);
                                  },
                                  icon: const Icon(Icons.my_location),
                                  color: AppColors.onPrimary),
                            ),
                          ),
                        )
                      ],
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        MarkerLayer(markers: markerList),
                        CurrentLocationLayer(),
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
