class Quadra {
  int id;
  int tipoQuadrasId;
  int empresasId;
  String descricao;
  String largura;
  String comprimento;
  bool possuiCobertura;
  bool excluido;
  String criadoEm;
  String atualizadoEm;
  List<String> imagens;

  Quadra(
      {this.id,
        this.tipoQuadrasId,
        this.empresasId,
        this.descricao,
        this.largura,
        this.comprimento,
        this.possuiCobertura,
        this.excluido,
        this.criadoEm,
        this.atualizadoEm,
        this.imagens});

  Quadra.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipoQuadrasId = json['tipo_quadras_id'];
    empresasId = json['empresas_id'];
    descricao = json['descricao'];
    largura = json['largura'];
    comprimento = json['comprimento'];
    possuiCobertura = json['possui_cobertura'];
    excluido = json['excluido'];
    criadoEm = json['criado_em'];
    atualizadoEm = json['atualizado_em'];
    imagens = json['imagens'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo_quadras_id'] = this.tipoQuadrasId;
    data['empresas_id'] = this.empresasId;
    data['descricao'] = this.descricao;
    data['largura'] = this.largura;
    data['comprimento'] = this.comprimento;
    data['possui_cobertura'] = this.possuiCobertura;
    data['excluido'] = this.excluido;
    data['criado_em'] = this.criadoEm;
    data['atualizado_em'] = this.atualizadoEm;
    data['imagens'] = this.imagens;
    return data;
  }
}