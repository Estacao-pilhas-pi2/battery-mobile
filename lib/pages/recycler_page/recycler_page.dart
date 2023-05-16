import 'dart:developer';

import 'package:estacao_pilhas/globals/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RecyclerPage extends StatefulWidget {
  const RecyclerPage({super.key});

  @override
  State<RecyclerPage> createState() => _RecyclerPageState();
}

class _RecyclerPageState extends State<RecyclerPage> {
  String username = "Usuário";
  int credits = 20;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Estação Pilhas")),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              child: Text(
                "Bem vindo(a) $username",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Container(
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
                        style:
                            TextStyle(color: AppColors.onPrimary, fontSize: 18),
                      )
                    ]),
              ),
            ),
            ElevatedButton(
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
            )
          ]),
        ),
      ),
    );
  }
}
