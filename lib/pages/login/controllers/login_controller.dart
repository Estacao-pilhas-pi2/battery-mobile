import 'dart:convert';

import 'package:estacao_pilhas/globals/utils.dart';
import 'package:estacao_pilhas/models/usuario.dart';

import '../../../globals/secure_storage.dart';
import '../../../services/usuario_service.dart';

class LoginController {
  Future login(String email, String password) async {
    try {
      Usuario requestedUser = await UsuarioService().login(email, password);
      SecureStorage secureStorage = SecureStorage();

      await secureStorage.write(
          Utils.userKey, jsonEncode(requestedUser.toJson()));

      return requestedUser;
    } catch (error) {
      return error.toString();
    }
  }
}
