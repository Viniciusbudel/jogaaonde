class PartidasRecentes {
  int id;
  int horarioQuadraId;
  int anfitriaoTimeId;
  int convidadoTimeId;
  String descricao;
  bool aceitaTime;
  bool excluido;
  String criadoEm;
  String atualizadoEm;
  String data_abertura;
  String data_fechamento;
  String quadra_id;
  String quadra_descricao;

  PartidasRecentes(
      {this.id,
        this.horarioQuadraId,
        this.anfitriaoTimeId,
        this.convidadoTimeId,
        this.descricao,
        this.aceitaTime,
        this.excluido,
        this.criadoEm,
        this.data_fechamento,
        this.data_abertura,
        this.quadra_id,
        this.quadra_descricao,
        this.atualizadoEm});

  PartidasRecentes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    horarioQuadraId = json['horario_quadra_id'];
    anfitriaoTimeId = json['anfitriao_time_id'];
    convidadoTimeId = json['convidado_time_id'];
    descricao = json['descricao'];
    aceitaTime = json['aceita_time'];
    excluido = json['excluido'];
    criadoEm = json['criado_em'];
    data_abertura = json['horario']["data_abertura"];
    data_fechamento = json['horario']["data_fechamento"];
    quadra_id = json['quadra']["quadra_id"];
    quadra_descricao = json['quadra']["descricao"];
    atualizadoEm = json['atualizado_em'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['horario_quadra_id'] = this.horarioQuadraId;
    data['anfitriao_time_id'] = this.anfitriaoTimeId;
    data['convidado_time_id'] = this.convidadoTimeId;
    data['descricao'] = this.descricao;
    data['aceita_time'] = this.aceitaTime;
    data['excluido'] = this.excluido;
    data['criado_em'] = this.criadoEm;
    data['atualizado_em'] = this.atualizadoEm;
    return data;
  }
}