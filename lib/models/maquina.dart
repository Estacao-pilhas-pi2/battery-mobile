import 'endereco.dart';

class Maquina {
  int? id;
  Endereco? endereco;
  String? descricao;
  int? precoAAA;
  int? precoAA;
  int? precoC;
  int? precoD;
  int? precoV9;
  int? quantidadeAAA;
  int? quantidadeAA;
  int? quantidadeC;
  int? quantidadeD;
  int? quantidadeV9;
  int? limiteMaximo;
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
    precoAAA = double.parse(json['preco_AAA']).round();
    precoAA = double.parse(json['preco_AA']).round();
    precoC = double.parse(json['preco_C']).round();
    precoD = double.parse(json['preco_D']).round();
    precoV9 = double.parse(json['preco_V9']).round();
    quantidadeAAA = json['quantidade_AAA'];
    quantidadeAA = json['quantidade_AA'];
    quantidadeC = json['quantidade_C'];
    quantidadeD = json['quantidade_D'];
    quantidadeV9 = json['quantidade_V9'];
    limiteMaximo = double.parse(json['limite_maximo']).round();
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

  int getCurrentBatteries() {
    return quantidadeAAA! +
        quantidadeAA! +
        quantidadeC! +
        quantidadeD! +
        quantidadeV9!;
  }
}
