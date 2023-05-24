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
            DialogInfoText(Icons.numbers, "ID: ${widget.station.idMaquina}"),
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
                  for (int index = 0;
                      index < widget.station.precos!.length;
                      index++)
                    TableRow(
                      children: <Widget>[
                        Text(
                          widget.station.precos![index].nome,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Center(
                            child: Text(
                                "${widget.station.precos![index].creditos}")),
                        Center(
                            child: Text(
                                "${widget.station.qtdPilhas![index].creditos}/100")),
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
