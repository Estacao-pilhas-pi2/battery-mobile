import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../services/usuario_service.dart';

class RegisterController {
  Future register(String email, String nome, String senha,
      String identification, String userType) async {
    try {
      await UsuarioService()
          .register(email, nome, senha, identification, userType);

      // if (userType == "Estabelecimento") {
      //   final registrationId = await FirebaseMessaging.instance.getToken();
      //   await UsuarioService().registerNotification(registrationId!, "android");
      // }
      return true;
    } catch (error) {
      return error.toString();
    }
  }
}
