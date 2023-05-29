import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:estacao_pilhas/models/usuario.dart';
import 'package:estacao_pilhas/services/usuario_service.dart';

import '../globals/utils.dart';
import '../models/maquina.dart';

import 'package:http/http.dart' as http;

import '../models/payment.dart';

class MaquinaService {
  static String listMaquinaEndpoint = "/api/maquina/";
  static String makePaymentEndpoint = "/api/pagamento/efetuar/";

  Future<List<Maquina>> getMaquinaList() async {
    final url = Uri.parse(Utils.url + listMaquinaEndpoint);

    Usuario user = await UsuarioService().getUserInfo();

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${user.access}'
      }).timeout(Duration(seconds: Utils.defaultTimeout));

      if (response.statusCode == 200) {
        return Maquina.fromJsonList(jsonDecode(response.body));
      } else {
        throw const HttpException('Dados incorretos.');
      }
    } catch (error) {
      if (error is TimeoutException) {
        throw const HttpException('Ocorreu um erro ao carregar as informaçoes');
      } else {
        throw HttpException('$error');
      }
    }
  }

  Future<Payment> makePayment(String paymentId) async {
    final url = Uri.parse(Utils.url + makePaymentEndpoint);
    Usuario user = await UsuarioService().getUserInfo();

    try {
      final response = await http.post(url, headers: {
        'Authorization': 'Bearer ${user.access}'
      }, body: {
        {"id_pagamento": paymentId}
      }).timeout(Duration(seconds: Utils.defaultTimeout));

      if (response.statusCode == 200) {
        return Payment.fromJson(jsonDecode(response.body));
      } else {
        throw HttpException('Erro: ${response.statusCode}');
      }
    } catch (error) {
      if (error is TimeoutException) {
        throw const HttpException('Ocorreu um erro ao carregar as informaçoes');
      } else {
        throw HttpException('$error');
      }
    }
  }
}
