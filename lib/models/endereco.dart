class Endereco {
  String cep;
  String bairro;
  String cidade;
  String estado;
  int numero;
  String complemento;
  String descricao;

  Endereco(this.cep, this.bairro, this.cidade, this.estado, this.numero,
      this.complemento, this.descricao);

  @override
  String toString() {
    return "$descricao $complemento $numero, $cep";
  }
}
