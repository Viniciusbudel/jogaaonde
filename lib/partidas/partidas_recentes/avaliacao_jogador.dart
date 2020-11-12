class AvaliacaoJogador {
  int jogadorId;
  int nota;

  AvaliacaoJogador({this.jogadorId, this.nota});

  AvaliacaoJogador.fromJson(Map<String, dynamic> json) {
    jogadorId = json['jogador_id'];
    nota = json['nota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jogador_id'] = this.jogadorId;
    data['nota'] = this.nota;
    return data;
  }
}