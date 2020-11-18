class CampeonatoChaves {
  List<Nivel1> nivel1;
  List<Nivel2> nivel2;
  List<Nivel3> nivel3;
  List<Nivel4> nivel4;

  CampeonatoChaves({this.nivel1, this.nivel2, this.nivel3, this.nivel4});

  CampeonatoChaves.fromJson(Map<String, dynamic> json) {
    if (json['nivel_1'] != null) {
      nivel1 = new List<Nivel1>();
      json['nivel_1'].forEach((v) {
        nivel1.add(new Nivel1.fromJson(v));
      });
    }
    if (json['nivel_2'] != null) {
      nivel2 = new List<Nivel2>();
      json['nivel_2'].forEach((v) {
        nivel2.add(new Nivel2.fromJson(v));
      });
    }
    if (json['nivel_3'] != null) {
      nivel3 = new List<Nivel3>();
      json['nivel_3'].forEach((v) {
        nivel3.add(new Nivel3.fromJson(v));
      });
    }
    if (json['nivel_4'] != null) {
      nivel4 = new List<Nivel4>();
      json['nivel_4'].forEach((v) {
        nivel4.add(new Nivel4.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nivel1 != null) {
      data['nivel_1'] = this.nivel1.map((v) => v.toJson()).toList();
    }
    if (this.nivel2 != null) {
      data['nivel_2'] = this.nivel2.map((v) => v.toJson()).toList();
    }
    if (this.nivel3 != null) {
      data['nivel_3'] = this.nivel3.map((v) => v.toJson()).toList();
    }
    if (this.nivel4 != null) {
      data['nivel_4'] = this.nivel4.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nivel1 {
  int partidaId;
  int timeAnfitriaoId;
  String timeAnfitriaoNome;
  int timeConvidadoId;
  String timeConvidadoNome;
  Horario horario;
  Quadra quadra;
  String resultado;

  Nivel1(
      {this.partidaId,
        this.timeAnfitriaoId,
        this.timeAnfitriaoNome,
        this.timeConvidadoId,
        this.timeConvidadoNome,
        this.horario,
        this.quadra,
        this.resultado});

  Nivel1.fromJson(Map<String, dynamic> json) {
    partidaId = json['partida_id'];
    timeAnfitriaoId = json['time_anfitriao_id'];
    timeAnfitriaoNome = json['time_anfitriao_nome'];
    timeConvidadoId = json['time_convidado_id'];
    timeConvidadoNome = json['time_convidado_nome'];
    horario =
    json['horario'] != null ? new Horario.fromJson(json['horario']) : null;
    quadra =
    json['quadra'] != null ? new Quadra.fromJson(json['quadra']) : null;
    resultado = json['resultado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partida_id'] = this.partidaId;
    data['time_anfitriao_id'] = this.timeAnfitriaoId;
    data['time_anfitriao_nome'] = this.timeAnfitriaoNome;
    data['time_convidado_id'] = this.timeConvidadoId;
    data['time_convidado_nome'] = this.timeConvidadoNome;
    if (this.horario != null) {
      data['horario'] = this.horario.toJson();
    }
    if (this.quadra != null) {
      data['quadra'] = this.quadra.toJson();
    }
    data['resultado'] = this.resultado;
    return data;
  }
}
class Nivel2 {
  int partidaId;
  int timeAnfitriaoId;
  String timeAnfitriaoNome;
  int timeConvidadoId;
  String timeConvidadoNome;
  Horario horario;
  Quadra quadra;
  String resultado;

  Nivel2(
      {this.partidaId,
        this.timeAnfitriaoId,
        this.timeAnfitriaoNome,
        this.timeConvidadoId,
        this.timeConvidadoNome,
        this.horario,
        this.quadra,
        this.resultado});

  Nivel2.fromJson(Map<String, dynamic> json) {
    partidaId = json['partida_id'];
    timeAnfitriaoId = json['time_anfitriao_id'];
    timeAnfitriaoNome = json['time_anfitriao_nome'];
    timeConvidadoId = json['time_convidado_id'];
    timeConvidadoNome = json['time_convidado_nome'];
    horario =
    json['horario'] != null ? new Horario.fromJson(json['horario']) : null;
    quadra =
    json['quadra'] != null ? new Quadra.fromJson(json['quadra']) : null;
    resultado = json['resultado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partida_id'] = this.partidaId;
    data['time_anfitriao_id'] = this.timeAnfitriaoId;
    data['time_anfitriao_nome'] = this.timeAnfitriaoNome;
    data['time_convidado_id'] = this.timeConvidadoId;
    data['time_convidado_nome'] = this.timeConvidadoNome;
    if (this.horario != null) {
      data['horario'] = this.horario.toJson();
    }
    if (this.quadra != null) {
      data['quadra'] = this.quadra.toJson();
    }
    data['resultado'] = this.resultado;
    return data;
  }
}
class Nivel3 {
  int partidaId;
  int timeAnfitriaoId;
  String timeAnfitriaoNome;
  int timeConvidadoId;
  String timeConvidadoNome;
  Horario horario;
  Quadra quadra;
  String resultado;

  Nivel3(
      {this.partidaId,
        this.timeAnfitriaoId,
        this.timeAnfitriaoNome,
        this.timeConvidadoId,
        this.timeConvidadoNome,
        this.horario,
        this.quadra,
        this.resultado});

  Nivel3.fromJson(Map<String, dynamic> json) {
    partidaId = json['partida_id'];
    timeAnfitriaoId = json['time_anfitriao_id'];
    timeAnfitriaoNome = json['time_anfitriao_nome'];
    timeConvidadoId = json['time_convidado_id'];
    timeConvidadoNome = json['time_convidado_nome'];
    horario =
    json['horario'] != null ? new Horario.fromJson(json['horario']) : null;
    quadra =
    json['quadra'] != null ? new Quadra.fromJson(json['quadra']) : null;
    resultado = json['resultado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partida_id'] = this.partidaId;
    data['time_anfitriao_id'] = this.timeAnfitriaoId;
    data['time_anfitriao_nome'] = this.timeAnfitriaoNome;
    data['time_convidado_id'] = this.timeConvidadoId;
    data['time_convidado_nome'] = this.timeConvidadoNome;
    if (this.horario != null) {
      data['horario'] = this.horario.toJson();
    }
    if (this.quadra != null) {
      data['quadra'] = this.quadra.toJson();
    }
    data['resultado'] = this.resultado;
    return data;
  }
}
class Nivel4 {
  int partidaId;
  int timeAnfitriaoId;
  String timeAnfitriaoNome;
  int timeConvidadoId;
  String timeConvidadoNome;
  Horario horario;
  Quadra quadra;
  String resultado;

  Nivel4(
      {this.partidaId,
        this.timeAnfitriaoId,
        this.timeAnfitriaoNome,
        this.timeConvidadoId,
        this.timeConvidadoNome,
        this.horario,
        this.quadra,
        this.resultado});

  Nivel4.fromJson(Map<String, dynamic> json) {
    partidaId = json['partida_id'];
    timeAnfitriaoId = json['time_anfitriao_id'];
    timeAnfitriaoNome = json['time_anfitriao_nome'];
    timeConvidadoId = json['time_convidado_id'];
    timeConvidadoNome = json['time_convidado_nome'];
    horario =
    json['horario'] != null ? new Horario.fromJson(json['horario']) : null;
    quadra =
    json['quadra'] != null ? new Quadra.fromJson(json['quadra']) : null;
    resultado = json['resultado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partida_id'] = this.partidaId;
    data['time_anfitriao_id'] = this.timeAnfitriaoId;
    data['time_anfitriao_nome'] = this.timeAnfitriaoNome;
    data['time_convidado_id'] = this.timeConvidadoId;
    data['time_convidado_nome'] = this.timeConvidadoNome;
    if (this.horario != null) {
      data['horario'] = this.horario.toJson();
    }
    if (this.quadra != null) {
      data['quadra'] = this.quadra.toJson();
    }
    data['resultado'] = this.resultado;
    return data;
  }
}

class Horario {
  int id;
  int quadraId;
  String dataAbertura;
  String dataFechamento;
  int preco;
  bool disponivel;
  String criadoEm;
  String atualizadoEm;

  Horario(
      {this.id,
        this.quadraId,
        this.dataAbertura,
        this.dataFechamento,
        this.preco,
        this.disponivel,
        this.criadoEm,
        this.atualizadoEm});

  Horario.fromJson(Map<String, dynamic> json) {
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

class Quadra {
  int id;
  int tipoQuadrasId;
  int empresasId;
  String descricao;
  String largura;
  String comprimento;
  bool possuiCobertura;
  String imagem;
  bool excluido;
  String criadoEm;
  String atualizadoEm;

  Quadra(
      {this.id,
        this.tipoQuadrasId,
        this.empresasId,
        this.descricao,
        this.largura,
        this.comprimento,
        this.possuiCobertura,
        this.imagem,
        this.excluido,
        this.criadoEm,
        this.atualizadoEm});

  Quadra.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipoQuadrasId = json['tipo_quadras_id'];
    empresasId = json['empresas_id'];
    descricao = json['descricao'];
    largura = json['largura'];
    comprimento = json['comprimento'];
    possuiCobertura = json['possui_cobertura'];
    imagem = json['imagem'];
    excluido = json['excluido'];
    criadoEm = json['criado_em'];
    atualizadoEm = json['atualizado_em'];
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
    data['imagem'] = this.imagem;
    data['excluido'] = this.excluido;
    data['criado_em'] = this.criadoEm;
    data['atualizado_em'] = this.atualizadoEm;
    return data;
  }

}