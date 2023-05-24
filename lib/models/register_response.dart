class RegisterResponse {
  UsuarioResponse? usuario;
  List<String>? cpf;
  List<String>? cnpj;

  RegisterResponse({this.usuario, this.cpf, this.cnpj});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    usuario = json['usuario'] != null
        ? UsuarioResponse.fromJson(json['usuario'])
        : null;
    cpf = json['cpf'] == null ? null : json['cpf'].cast<String>();
    cnpj = json['cnpj'] == null ? null : json['cnpj'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (usuario != null) {
      data['usuario'] = usuario!.toJson();
    }
    data['cpf'] = cpf;
    data['cnpj'] = cnpj;
    return data;
  }
}

class UsuarioResponse {
  List<String>? email;
  List<String>? senha;

  UsuarioResponse({this.email, this.senha});

  UsuarioResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'] == null ? null : json['email'].cast<String>();
    senha = json['senha'] == null ? null : json['senha'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['senha'] = senha;
    return data;
  }
}
