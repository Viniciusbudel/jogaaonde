class FifaTime {
  String id;
  String descricao;
  String corPrimaria;
  String corSecundaria;
  String corFonte;
  String escudo;
  String excluido;
  String criadoEm;
  String atualizadoEm;

  FifaTime(
      {this.id,
        this.descricao,
        this.corPrimaria,
        this.corSecundaria,
        this.corFonte,
        this.escudo,
        this.excluido,
        this.criadoEm,
        this.atualizadoEm});

  FifaTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    corPrimaria = json['cor_primaria'];
    corSecundaria = json['cor_secundaria'];
    corFonte = json['cor_fonte'];
    escudo = json['escudo'];
    excluido = json['excluido'];
    criadoEm = json['criado_em'];
    atualizadoEm = json['atualizado_em'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['cor_primaria'] = this.corPrimaria;
    data['cor_secundaria'] = this.corSecundaria;
    data['cor_fonte'] = this.corFonte;
    data['escudo'] = this.escudo;
    data['excluido'] = this.excluido;
    data['criado_em'] = this.criadoEm;
    data['atualizado_em'] = this.atualizadoEm;
    return data;
  }
}