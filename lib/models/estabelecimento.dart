import 'usuario.dart';

class Estabelecimento {
  Usuario? usuario;
  String? cnpj;

  Estabelecimento({this.usuario, this.cnpj});

  Estabelecimento.fromJson(Map<String, dynamic> json) {
    usuario =
        json['usuario'] != null ? Usuario.fromJson(json['usuario']) : null;
    cnpj = json['cnpj'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usuario != null) {
      data['usuario'] = usuario!.toJson();
    }
    data['cnpj'] = cnpj;
    return data;
  }
}
