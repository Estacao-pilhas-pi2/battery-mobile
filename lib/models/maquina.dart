import 'endereco.dart';

class Maquina {
  int? id;
  Endereco? endereco;
  String? descricao;
  String? precoAAA;
  String? precoAA;
  String? precoC;
  String? precoD;
  String? precoV9;
  int? quantidadeAAA;
  int? quantidadeAA;
  int? quantidadeC;
  int? quantidadeD;
  int? quantidadeV9;
  String? limiteMaximo;
  int? estabelecimento;

  Maquina(
      {this.id,
      this.endereco,
      this.descricao,
      this.precoAAA,
      this.precoAA,
      this.precoC,
      this.precoD,
      this.precoV9,
      this.quantidadeAAA,
      this.quantidadeAA,
      this.quantidadeC,
      this.quantidadeD,
      this.quantidadeV9,
      this.limiteMaximo,
      this.estabelecimento});

  Maquina.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    endereco =
        json['endereco'] != null ? Endereco.fromJson(json['endereco']) : null;
    descricao = json['descricao'];
    precoAAA = json['preco_AAA'];
    precoAA = json['preco_AA'];
    precoC = json['preco_C'];
    precoD = json['preco_D'];
    precoV9 = json['preco_V9'];
    quantidadeAAA = json['quantidade_AAA'];
    quantidadeAA = json['quantidade_AA'];
    quantidadeC = json['quantidade_C'];
    quantidadeD = json['quantidade_D'];
    quantidadeV9 = json['quantidade_V9'];
    limiteMaximo = json['limite_maximo'];
    estabelecimento = json['estabelecimento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['endereco'] = endereco;
    data['descricao'] = descricao;
    data['preco_AAA'] = precoAAA;
    data['preco_AA'] = precoAA;
    data['preco_C'] = precoC;
    data['preco_D'] = precoD;
    data['preco_V9'] = precoV9;
    data['quantidade_AAA'] = quantidadeAAA;
    data['quantidade_AA'] = quantidadeAA;
    data['quantidade_C'] = quantidadeC;
    data['quantidade_D'] = quantidadeD;
    data['quantidade_V9'] = quantidadeV9;
    data['limite_maximo'] = limiteMaximo;
    data['estabelecimento'] = estabelecimento;
    return data;
  }

  static List<Maquina> fromJsonList(jsonDecode) {
    List<Maquina> maquinaList = [];
    jsonDecode.forEach((var item) => {maquinaList.add(Maquina.fromJson(item))});
    return maquinaList;
  }
}
