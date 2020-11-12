class CadastrarPartida {
  int horarioQuadraId;
  int anfitriaoTimeId;
  int convidadoTimeId;
  String descricao;
  bool aceitaTime;

  CadastrarPartida(
      {this.horarioQuadraId,
        this.anfitriaoTimeId,
        this.convidadoTimeId,
        this.descricao,
        this.aceitaTime});

  CadastrarPartida.fromJson(Map<String, dynamic> json) {
    horarioQuadraId = json['horario_quadra_id'];
    anfitriaoTimeId = json['anfitriao_time_id'];
    convidadoTimeId = json['convidado_time_id'];
    descricao = json['descricao'];
    aceitaTime = json['aceita_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['horario_quadra_id'] = this.horarioQuadraId;
    data['anfitriao_time_id'] = this.anfitriaoTimeId;
    data['convidado_time_id'] = this.convidadoTimeId;
    data['descricao'] = this.descricao;
    data['aceita_time'] = this.aceitaTime;
    return data;
  }
}