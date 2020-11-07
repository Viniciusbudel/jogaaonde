class HorarioPartida {
  int id;
  int quadraId;
  String dataAbertura;
  String dataFechamento;
  double preco;
  bool disponivel;
  String criadoEm;
  String atualizadoEm;

  HorarioPartida(
      {this.id,
        this.quadraId,
        this.dataAbertura,
        this.dataFechamento,
        this.preco,
        this.disponivel,
        this.criadoEm,
        this.atualizadoEm});

  HorarioPartida.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quadraId = json['quadra_id'];
    dataAbertura = json['data_abertura'];
    dataFechamento = json['data_fechamento'];
    preco = json['preco'];
    disponivel = json['disponivel'];
    criadoEm = json['criado_em'];
    atualizadoEm = json['atualizado_em'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quadra_id'] = this.quadraId;
    data['data_abertura'] = this.dataAbertura;
    data['data_fechamento'] = this.dataFechamento;
    data['preco'] = this.preco;
    data['disponivel'] = this.disponivel;
    data['criado_em'] = this.criadoEm;
    data['atualizado_em'] = this.atualizadoEm;
    return data;
  }
}