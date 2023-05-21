import 'package:estacao_pilhas/models/endereco.dart';
import 'package:estacao_pilhas/models/pilha.dart';

class Maquina {
  int idMaquina;
  List<Pilha> qtdPilhas;
  String descricao;
  List<Pilha> precos;
  Endereco endereco;

  Maquina(this.descricao, this.idMaquina, this.qtdPilhas, this.precos,
      this.endereco);
}
