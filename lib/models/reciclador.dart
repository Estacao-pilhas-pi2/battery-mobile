import 'usuario.dart';

class Reciclador {
  Usuario? usuario;
  String? cpf;

  Reciclador({this.usuario, this.cpf});

  Reciclador.fromJson(Map<String, dynamic> json) {
    usuario =
        json['usuario'] != null ? Usuario.fromJson(json['usuario']) : null;
    cpf = json['cpf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usuario != null) {
      data['usuario'] = usuario!.toJson();
    }
    data['cpf'] = cpf;
    return data;
  }
}
