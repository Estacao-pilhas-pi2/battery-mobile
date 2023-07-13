import 'package:estacao_pilhas/globals/colors.dart';
import 'package:estacao_pilhas/pages/payment_history/payment_history.dart';
import 'package:estacao_pilhas/utils/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../models/usuario.dart';
import '../credits_received/credits_received.dart';
import '../qr_code_reader/qr_code_reader.dart';
import 'controllers/recycler_page_controller.dart';

class RecyclerPage extends StatefulWidget {
  const RecyclerPage({super.key});

  @override
  State<RecyclerPage> createState() => _RecyclerPageState();
}

class _RecyclerPageState extends State<RecyclerPage> {
  late Usuario usuario = Usuario();
  late String creditos = "1.0";
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
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> initialRequest() async {
    List<Marker> requestedMarkerList =
        await RecyclerPageController().getStations();
    Position requestedPosition = await getUserPosition();
    Usuario requestedUser = await RecyclerPageController().getUserInfo();
    String requestedCredits =
        await RecyclerPageController().getRecyclerCredits();

    setState(() {
      markerList = requestedMarkerList;
      userLocation = requestedPosition;
      usuario = requestedUser;
      creditos = requestedCredits;
      isScreenLoading = false;
    });
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
                        "Bem vindo(a) ${usuario.nome}",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
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
                                  color: StaticColors.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const Spacer(),
                            Text(
                              "$creditos Créditos",
                              style: TextStyle(
                                  color: StaticColors.onPrimary, fontSize: 18),
                            )
                          ]),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const PaymentHistoryPage();
                        }));
                      },
                      child: const Text(
                        "Ver histórico",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
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
                                    Position requestedPosition =
                                        await getUserPosition();
                                    setState(
                                        () => userLocation = requestedPosition);
                                    _mapController.move(
                                        LatLng(userLocation.latitude,
                                            userLocation.longitude),
                                        16);
                                  },
                                  icon: const Icon(Icons.my_location),
                                  color: StaticColors.onPrimary),
                            ),
                          ),
                        )
                      ],
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        CurrentLocationLayer(),
                        MarkerLayer(markers: markerList),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QrCodeReader(
                          displayText:
                              "Leia o Código QR localizado na parte X da máquina",
                          onRead: (capture, context) {
                            if (capture['id_pagamento'] != null) {
                              debugPrint('Valor lido: $capture');
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => CreditsReceived(
                                          paymentId: capture['id_pagamento']
                                              .toString())),
                                  (Route<dynamic> route) => route.isFirst);
                              return true;
                            } else {
                              debugPrint('Valor errado');
                              return false;
                            }
                          },
                        ),
                      )),
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
