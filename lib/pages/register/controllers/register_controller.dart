import '../../../services/usuario_service.dart';

class RegisterController {
  Future register(String email, String nome, String senha,
      String identification, String userType) async {
    try {
      await UsuarioService()
          .register(email, nome, senha, identification, userType);

      return true;
    } catch (error) {
      return error.toString();
    }
  }
}
