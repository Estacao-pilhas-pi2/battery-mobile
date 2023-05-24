import 'endereco.dart';
import 'pilha.dart';

class Maquina {
  String? descricao;
  Endereco? endereco;
  int? idMaquina;
  int? precoAAA;
  int? precoAA;
  int? precoC;
  int? precoD;
  int? precoV9;
  int? estabelecimento;
  List<Pilha>? qtdPilhas;
  List<Pilha>? precos;

  Maquina(
      {this.descricao,
      this.endereco,
      this.precoAAA,
      this.precoAA,
      this.precoC,
      this.precoD,
      this.precoV9,
      this.estabelecimento,
      this.idMaquina,
      this.precos,
      this.qtdPilhas});

  Maquina.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    endereco =
        json['endereco'] != null ? Endereco.fromJson(json['endereco']) : null;
    precoAAA = json['preco_AAA'];
    precoAA = json['preco_AA'];
    precoC = json['preco_C'];
    precoD = json['preco_D'];
    precoV9 = json['preco_V9'];
    estabelecimento = json['estabelecimento'];
    precos = json['precos'];
    qtdPilhas = json['qtdPilhas'];
    idMaquina = json['idMaquina'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = descricao;
    if (endereco != null) {
      data['endereco'] = endereco!.toJson();
    }
    data['preco_AAA'] = precoAAA;
    data['preco_AA'] = precoAA;
    data['preco_C'] = precoC;
    data['preco_D'] = precoD;
    data['preco_V9'] = precoV9;
    data['estabelecimento'] = estabelecimento;
    data['precos'] = precos;
    data['qtdPilhas'] = qtdPilhas;
    data['idMaquina'] = idMaquina;
    return data;
  }

  static List<Maquina> fromJsonList(jsonDecode) {
    List<Maquina> maquinaList = [];
    jsonDecode.forEach((var item) => {maquinaList.add(Maquina.fromJson(item))});
    return maquinaList;
  }
}
