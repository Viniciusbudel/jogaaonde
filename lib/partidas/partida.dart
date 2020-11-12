class Partida {
  int id;
  int horarioQuadraId;
  int convidadoTimeId;
  String descricao;
  bool aceitaTime;

  Partida(
      {this.id,
        this.horarioQuadraId,
        this.convidadoTimeId,
        this.descricao,
        this.aceitaTime});

  Partida.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    horarioQuadraId = json['horario_quadra_id'];
    convidadoTimeId = json['convidado_time_id'];
    descricao = json['descricao'];
    aceitaTime = json['aceita_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['horario_quadra_id'] = this.horarioQuadraId;
    data['convidado_time_id'] = this.convidadoTimeId;
    data['descricao'] = this.descricao;
    data['aceita_time'] = this.aceitaTime;
    return data;
  }
}