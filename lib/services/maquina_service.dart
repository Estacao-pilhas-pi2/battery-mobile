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
  static String createMaquinaEndpoint = "/api/maquina/{id}/";
  static String emptyMaquinaEndpoint = "/api/maquina/esvaziar/";

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
        throw HttpException('E ${response.statusCode}');
      }
    } catch (error) {
      if (error is TimeoutException) {
        throw const HttpException('Ocorreu um erro ao carregar as informaçoes');
      } else {
        throw HttpException('$error');
      }
    }
  }

  Future editMaquina(int id, Map changes) async {
    final url = Uri.parse(
        Utils.url + createMaquinaEndpoint.replaceFirst("{id}", id.toString()));

    Usuario user = await UsuarioService().getUserInfo();

    try {
      final response = await http.patch(url,
          body: jsonEncode(changes),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user.access}'
          }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Maquina.fromJson(jsonDecode(response.body));
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

  Future emptyMaquina(Map id) async {
    final url = Uri.parse(Utils.url + emptyMaquinaEndpoint);

    Usuario user = await UsuarioService().getUserInfo();

    try {
      final response = await http.post(url, body: jsonEncode(id), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.access}'
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return response.body; //alterar
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

  Future<Maquina> createMaquina(int id, Maquina maquina) async {
    final url = Uri.parse(
        Utils.url + createMaquinaEndpoint.replaceFirst("{id}", id.toString()));

    Usuario user = await UsuarioService().getUserInfo();

    try {
      final response = await http.put(url, body: jsonEncode(maquina), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.access}'
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Maquina.fromJson(jsonDecode(response.body));
      } else {
        throw const HttpException('Dados incorretos.');
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
