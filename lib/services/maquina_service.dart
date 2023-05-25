import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:estacao_pilhas/models/usuario.dart';
import 'package:estacao_pilhas/services/usuario_service.dart';

import '../globals/utils.dart';
import '../models/maquina.dart';

import 'package:http/http.dart' as http;

class MaquinaService {
  static String listMaquinaEndpoint = "/api/maquina/";

  Future<List<Maquina>> getMaquinaList() async {
    final url = Uri.parse(Utils.url + listMaquinaEndpoint);

    Usuario user = await UsuarioService().getUserInfo();

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${user.access}'
      }).timeout(const Duration(seconds: 10));

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
}
