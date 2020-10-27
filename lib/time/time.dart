class Time {
  int id;
  String nome;
  String descricao;
  String escudo;
  String cidade;
  String uf;
  int jogador_adm;
  bool aceitaIntegrantes;

  Time(
      {this.nome,
        this.id,
        this.descricao,
        this.escudo,
        this.cidade,
        this.uf,
        this.jogador_adm,
        this.aceitaIntegrantes});

  Time.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    id = json['id'];
    descricao = json['descricao'];
    escudo = json['escudo'];
    cidade = json['cidade'];
    jogador_adm = json['jogador_adm'];
    uf = json['uf'];
    aceitaIntegrantes = json['aceita_integrantes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['escudo'] = this.escudo;
    data['cidade'] = this.cidade;
    data['uf'] = this.uf;
    //data['jogador_adm'] = this.jogador_adm;
    data['aceita_integrantes'] = this.aceitaIntegrantes;
    return data;
  }
}