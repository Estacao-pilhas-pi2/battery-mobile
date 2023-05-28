class Usuario {
  String? refresh;
  String? access;
  String? id;
  String? email;
  String? nome;
  bool? estabelecimento;
  String? identificador;

  Usuario(
      {this.refresh,
      this.access,
      this.id,
      this.email,
      this.nome,
      this.estabelecimento});

  Usuario.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
    id = json['id'];
    email = json['email'];
    nome = json['nome'];
    estabelecimento = json['estabelecimento'];
    identificador = json['identificador'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refresh'] = refresh;
    data['access'] = access;
    data['id'] = id;
    data['email'] = email;
    data['nome'] = nome;
    data['estabelecimento'] = estabelecimento;
    data['identificador'] = identificador;
    return data;
  }
}
