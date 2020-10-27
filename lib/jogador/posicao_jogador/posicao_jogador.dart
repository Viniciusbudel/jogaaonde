class PosicaoJogador {
  int id;
  String descricao;
  String excluido;
  String criadoEm;
  String atualizadoEm;

  PosicaoJogador(
      {this.id,
        this.descricao,
        this.excluido,
        this.criadoEm,
        this.atualizadoEm});

  PosicaoJogador.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    excluido = json['excluido'];
    criadoEm = json['criado_em'];
    atualizadoEm = json['atualizado_em'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['excluido'] = this.excluido;
    data['criado_em'] = this.criadoEm;
    data['atualizado_em'] = this.atualizadoEm;
    return data;
  }
}