class Endereco {
  String cep;
  String bairro;
  String cidade;
  String estado;
  int numero;
  String complemento;
  String descricao;
  double latitude;
  double longitude;

  Endereco(this.cep, this.bairro, this.cidade, this.estado, this.numero,
      this.complemento, this.descricao, this.latitude, this.longitude);

  @override
  String toString() {
    return "$descricao $complemento $numero, $cep";
  }
}
