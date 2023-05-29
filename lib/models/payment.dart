class Payment {
  int? quantidadePilhaAA;
  int? quantidadePilhaAAA;
  int? quantidadePilhaC;
  int? quantidadePilhaD;
  int? quantidadePilhaV9;
  String? creditos;

  Payment(
      {this.quantidadePilhaAA,
      this.quantidadePilhaAAA,
      this.quantidadePilhaC,
      this.quantidadePilhaD,
      this.quantidadePilhaV9,
      this.creditos});

  Payment.fromJson(Map<String, dynamic> json) {
    quantidadePilhaAA = json['quantidade_pilha_AA'];
    quantidadePilhaAAA = json['quantidade_pilha_AAA'];
    quantidadePilhaC = json['quantidade_pilha_C'];
    quantidadePilhaD = json['quantidade_pilha_D'];
    quantidadePilhaV9 = json['quantidade_pilha_V9'];
    creditos = json['creditos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantidade_pilha_AA'] = quantidadePilhaAA;
    data['quantidade_pilha_AAA'] = quantidadePilhaAAA;
    data['quantidade_pilha_C'] = quantidadePilhaC;
    data['quantidade_pilha_D'] = quantidadePilhaD;
    data['quantidade_pilha_V9'] = quantidadePilhaV9;
    data['creditos'] = creditos;
    return data;
  }
}
