class PaymentReport {
  String? id;
  int? quantidadePilhaAA;
  int? quantidadePilhaAAA;
  int? quantidadePilhaC;
  int? quantidadePilhaD;
  int? quantidadePilhaV9;
  bool? utilizado;
  String? dataVencimento;
  int? maquina;
  double? valorTotal;
  double? precoAAA;
  double? precoAA;
  double? precoV9;
  double? precoC;
  double? precoD;

  PaymentReport(
      {this.id,
      this.quantidadePilhaAA,
      this.quantidadePilhaAAA,
      this.quantidadePilhaC,
      this.quantidadePilhaD,
      this.quantidadePilhaV9,
      this.utilizado,
      this.dataVencimento,
      this.maquina,
      this.valorTotal,
      this.precoAAA,
      this.precoAA,
      this.precoV9,
      this.precoC,
      this.precoD});

  PaymentReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantidadePilhaAA = json['quantidade_pilha_AA'];
    quantidadePilhaAAA = json['quantidade_pilha_AAA'];
    quantidadePilhaC = json['quantidade_pilha_C'];
    quantidadePilhaD = json['quantidade_pilha_D'];
    quantidadePilhaV9 = json['quantidade_pilha_V9'];
    utilizado = json['utilizado'];
    dataVencimento = json['data_vencimento'];
    maquina = json['maquina'];
    valorTotal = json['valor_total'];
    precoAAA = double.parse(json['preco_AAA']);
    precoAA = double.parse(json['preco_AA']);
    precoV9 = double.parse(json['preco_V9']);
    precoC = double.parse(json['preco_C']);
    precoD = double.parse(json['preco_D']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantidade_pilha_AA'] = quantidadePilhaAA;
    data['quantidade_pilha_AAA'] = quantidadePilhaAAA;
    data['quantidade_pilha_C'] = quantidadePilhaC;
    data['quantidade_pilha_D'] = quantidadePilhaD;
    data['quantidade_pilha_V9'] = quantidadePilhaV9;
    data['utilizado'] = utilizado;
    data['data_vencimento'] = dataVencimento;
    data['maquina'] = maquina;
    data['valor_total'] = valorTotal;
    data['preco_AAA'] = precoAAA;
    data['preco_AA'] = precoAA;
    data['preco_V9'] = precoV9;
    data['preco_C'] = precoC;
    data['preco_D'] = precoD;
    return data;
  }

  static List<PaymentReport> fromJsonList(jsonDecode) {
    List<PaymentReport> paymentReportList = [];
    jsonDecode.forEach(
        (var item) => {paymentReportList.add(PaymentReport.fromJson(item))});
    return paymentReportList;
  }
}
