import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../globals/utils.dart';
import '../models/usuario.dart';

class UsuarioService {
  static String endpoint = "/api/login/";

  Future<Usuario> login(String email, String password) async {
    final url = Uri.parse(Utils.url + endpoint);

    try {
      final response = await http.post(url, body: {
        "email": email,
        "password": password
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Usuario.fromJson(jsonDecode(response.body));
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
