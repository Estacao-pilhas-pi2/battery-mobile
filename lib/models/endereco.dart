class Endereco {
  String? cep;
  String? estado;
  String? cidade;
  String? bairro;
  String? rua;
  int? numero;
  String? complemento;
  double? latitude;
  double? longitude;

  Endereco(
      {this.cep,
      this.estado,
      this.cidade,
      this.bairro,
      this.rua,
      this.numero,
      this.complemento,
      this.latitude,
      this.longitude});

  Endereco.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    estado = json['estado'];
    cidade = json['cidade'];
    bairro = json['bairro'];
    rua = json['rua'];
    numero = json['numero'];
    complemento = json['complemento'];
    latitude = double.parse(json['latitude']);
    longitude = double.parse(json['longitude']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['estado'] = estado;
    data['cidade'] = cidade;
    data['bairro'] = bairro;
    data['rua'] = rua;
    data['numero'] = numero;
    data['complemento'] = complemento;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }

  @override
  String toString() {
    return "$rua $complemento $numero";
  }
}
