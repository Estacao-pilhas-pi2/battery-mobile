class Reciclador {
  int? id;
  int? usuario;
  String? cpf;
  String? credito;

  Reciclador({this.usuario, this.cpf});

  Reciclador.fromJson(Map<String, dynamic> json) {
    usuario = json['usuario'];
    id = json['id'];
    cpf = json['cpf'];
    credito = json['credito'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usuario != null) {
      data['usuario'] = usuario;
    }
    data['id'] = id;
    data['cpf'] = cpf;
    data['credito'] = credito;
    return data;
  }
}
