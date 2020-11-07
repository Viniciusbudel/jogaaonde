class Campeonato {
  int id;
  int empresaId;
  String nome;
  String descricao;
  int taxa;
  int qtdParticipantes;
  String prazoInscricao;
  String premio1;
  String premio2;
  String premio3;
  bool excluido;
  String criadoEm;
  String atualizadoEm;

  Campeonato(
      {this.id,
        this.empresaId,
        this.nome,
        this.descricao,
        this.taxa,
        this.qtdParticipantes,
        this.prazoInscricao,
        this.premio1,
        this.premio2,
        this.premio3,
        this.excluido,
        this.criadoEm,
        this.atualizadoEm});

  Campeonato.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empresaId = json['empresa_id'];
    nome = json['nome'];
    descricao = json['descricao'];
    taxa = json['taxa'];
    qtdParticipantes = json['qtd_participantes'];
    prazoInscricao = json['prazo_inscricao'];
    premio1 = json['premio1'];
    premio2 = json['premio2'];
    premio3 = json['premio3'];
    excluido = json['excluido'];
    criadoEm = json['criado_em'];
    atualizadoEm = json['atualizado_em'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['empresa_id'] = this.empresaId;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['taxa'] = this.taxa;
    data['qtd_participantes'] = this.qtdParticipantes;
    data['prazo_inscricao'] = this.prazoInscricao;
    data['premio1'] = this.premio1;
    data['premio2'] = this.premio2;
    data['premio3'] = this.premio3;
    data['excluido'] = this.excluido;
    data['criado_em'] = this.criadoEm;
    data['atualizado_em'] = this.atualizadoEm;
    return data;
  }
}