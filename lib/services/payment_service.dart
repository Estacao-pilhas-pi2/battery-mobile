import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../globals/utils.dart';
import '../models/payment.dart';
import '../models/payment_report.dart';
import '../models/usuario.dart';
import 'usuario_service.dart';

class PaymentService {
  static String paymentReportsEndpoint = "/api/pagamento";
  static String paymentMachineReportsEndpoint = "/api/maquina/";
  static String makePaymentEndpoint = "/api/pagamento/efetuar/";

  Future<Payment> makePayment(String paymentId) async {
    final url = Uri.parse(Utils.url + makePaymentEndpoint);
    Usuario user = await UsuarioService().getUserInfo();
    Object body = {"id_pagamento": paymentId};

    try {
      final response = await http
          .post(url,
              headers: {'Authorization': 'Bearer ${user.access}'}, body: body)
          .timeout(Duration(seconds: Utils.defaultTimeout));

      if (response.statusCode == 201) {
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

  Future<List<PaymentReport>> getPaymentReports() async {
    var url;

    url = Uri.parse(Utils.url + paymentReportsEndpoint);

    Usuario user = await UsuarioService().getUserInfo();

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.access}'
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return PaymentReport.fromJsonList(jsonDecode(response.body));
      } else {
        throw const HttpException('Ocorreu um erro.');
      }
    } catch (error) {
      if (error is TimeoutException) {
        throw const HttpException('Ocorreu um erro ao carregar as informações');
      } else {
        throw HttpException('$error');
      }
    }
  }

  Future<List<PaymentReport>> getPaymentMachineReports(int maquinaId) async {
    var url;

    url = Uri.parse(
        "${Utils.url}$paymentMachineReportsEndpoint$maquinaId/historico");

    Usuario user = await UsuarioService().getUserInfo();

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.access}'
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return PaymentReport.fromMaquinaJsonList(jsonDecode(response.body));
      } else {
        throw const HttpException('Ocorreu um erro.');
      }
    } catch (error) {
      if (error is TimeoutException) {
        throw const HttpException('Ocorreu um erro ao carregar as informações');
      } else {
        throw HttpException('$error');
      }
    }
  }
}
