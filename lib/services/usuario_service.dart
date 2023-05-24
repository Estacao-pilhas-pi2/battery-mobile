import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../globals/secure_storage.dart';
import '../globals/utils.dart';
import '../models/reciclador.dart';
import '../models/register_response.dart';
import '../models/usuario.dart';

class UsuarioService {
  static String loginEndpoint = "/api/login/";
  static String registerEstabelecimento = "/api/estabelecimento/";
  static String recicladorEndpoint = "/api/reciclador/";

  Future<Usuario> login(String email, String password) async {
    final url = Uri.parse(Utils.url + loginEndpoint);

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

  Future<bool> register(String email, String nome, String senha,
      String identification, String userType) async {
    String endpoint = "";
    Object? body;

    if (userType == "Reciclador") {
      endpoint = recicladorEndpoint;
      body = {
        "usuario": {"nome": nome, "email": email, "senha": senha},
        "cpf": identification
      };
    } else {
      endpoint = registerEstabelecimento;
      body = {
        "usuario": {"nome": nome, "email": email, "senha": senha},
        "cnpj": identification
      };
    }

    final url = Uri.parse(Utils.url + endpoint);

    try {
      final response = await http
          .post(url,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 201) {
        return true;
      } else {
        RegisterResponse decodedError =
            RegisterResponse.fromJson(jsonDecode(response.body));
        if (decodedError.usuario?.email != null) {
          throw ("[Email] ${decodedError.usuario!.email!.first}");
        } else if (decodedError.usuario?.senha != null) {
          throw ("[Senha] ${decodedError.usuario!.senha!.first}");
        } else if (decodedError.cpf != null && userType == "Reciclador") {
          throw ("[CPF]${decodedError.cpf!.first}");
        } else if (decodedError.cnpj != null && userType == "Estabelecimento") {
          throw ("[CNPJ] ${decodedError.cnpj!.first}");
        }
      }
      return false;
    } catch (error) {
      if (error is TimeoutException) {
        throw const HttpException('Ocorreu um erro ao carregar as informaçoes');
      } else {
        throw HttpException('$error');
      }
    }
  }

  Future<Usuario> getUserInfo() async {
    SecureStorage secureStorage = SecureStorage();
    var secureStorageUser = await secureStorage.read(Utils.userKey);

    return Usuario.fromJson(jsonDecode(secureStorageUser));
  }

  Future<Reciclador> getCredits(String id) async {
    final url = Uri.parse("${Utils.url}$recicladorEndpoint$id/");

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Reciclador.fromJson(jsonDecode(response.body));
      } else {
        throw const HttpException('Não foi possível acessar os dados.');
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
