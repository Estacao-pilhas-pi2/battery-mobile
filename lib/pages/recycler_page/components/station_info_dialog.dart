import 'package:estacao_pilhas/models/maquina.dart';
import 'package:flutter/material.dart';

import 'dialog_info_text.dart';

class StationInfoDialog extends StatefulWidget {
  final Maquina station;

  const StationInfoDialog(this.station, {super.key});

  @override
  State<StationInfoDialog> createState() => _StationInfoDialogState();
}

class _StationInfoDialogState extends State<StationInfoDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      title: const Center(child: Text('Informações')),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            DialogInfoText(Icons.numbers, "ID: ${widget.station.id}"),
            DialogInfoText(Icons.place, "Local: ${widget.station.endereco}"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(50),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  const TableRow(
                    children: <Widget>[
                      Text(""),
                      Center(
                          child: Text(
                        "Créditos",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      Center(
                          child: Text(
                        "Capacidade",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      const Text(
                        "AA",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Center(child: Text(widget.station.precoAA.toString())),
                      Center(child: Text("${widget.station.quantidadeAA}/100")),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      const Text(
                        "AAA",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Center(child: Text(widget.station.precoAAA.toString())),
                      Center(
                          child: Text("${widget.station.quantidadeAAA}/100")),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      const Text(
                        "C",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Center(child: Text(widget.station.precoC.toString())),
                      Center(child: Text("${widget.station.quantidadeC}/100")),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      const Text(
                        "D",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Center(child: Text(widget.station.precoD.toString())),
                      Center(child: Text("${widget.station.quantidadeD}/100")),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      const Text(
                        "9V",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Center(child: Text(widget.station.precoV9.toString())),
                      Center(child: Text("${widget.station.quantidadeV9}/100")),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(86, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
              ),
              child: const Text(
                "Voltar",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
