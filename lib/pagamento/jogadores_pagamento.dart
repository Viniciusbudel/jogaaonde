class JogadorPagamento {
  int id;
  int partidaId;
  int jogadorId;
  int valor;
  int statusId;
  String criadoEm;
  String atualizadoEm;
  Jogador jogador;
  Status status;

  JogadorPagamento(
      {this.id,
        this.partidaId,
        this.jogadorId,
        this.valor,
        this.statusId,
        this.criadoEm,
        this.atualizadoEm,
        this.jogador,
        this.status});

  JogadorPagamento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partidaId = json['partida_id'];
    jogadorId = json['jogador_id'];
    valor = json['valor'];
    statusId = json['status_id'];
    criadoEm = json['criado_em'];
    atualizadoEm = json['atualizado_em'];
    jogador =
    json['jogador'] != null ? new Jogador.fromJson(json['jogador']) : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['partida_id'] = this.partidaId;
    data['jogador_id'] = this.jogadorId;
    data['valor'] = this.valor;
    data['status_id'] = this.statusId;
    data['criado_em'] = this.criadoEm;
    data['atualizado_em'] = this.atualizadoEm;
    if (this.jogador != null) {
      data['jogador'] = this.jogador.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    return data;
  }
}

class Jogador {
  int id;
  String nome;
  String cpf;
  String email;
  String telefone;
  int fifaTimesId;
  bool disponivel;
  String cep;
  String logradouro;
  int numero;
  String bairro;
  String cidade;
  String uf;
  String pais;
  Null senha;
  bool excluido;
  String criadoEm;
  String atualizadoEm;

  Jogador(
      {this.id,
        this.nome,
        this.cpf,
        this.email,
        this.telefone,
        this.fifaTimesId,
        this.disponivel,
        this.cep,
        this.logradouro,
        this.numero,
        this.bairro,
        this.cidade,
        this.uf,
        this.pais,
        this.senha,
        this.excluido,
        this.criadoEm,
        this.atualizadoEm});

  Jogador.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    cpf = json['cpf'];
    email = json['email'];
    telefone = json['telefone'];
    fifaTimesId = json['fifa_times_id'];
    disponivel = json['disponivel'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    uf = json['uf'];
    pais = json['pais'];
    senha = json['senha'];
    excluido = json['excluido'];
    criadoEm = json['criado_em'];
    atualizadoEm = json['atualizado_em'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    data['fifa_times_id'] = this.fifaTimesId;
    data['disponivel'] = this.disponivel;
    data['cep'] = this.cep;
    data['logradouro'] = this.logradouro;
    data['numero'] = this.numero;
    data['bairro'] = this.bairro;
    data['cidade'] = this.cidade;
    data['uf'] = this.uf;
    data['pais'] = this.pais;
    data['senha'] = this.senha;
    data['excluido'] = this.excluido;
    data['criado_em'] = this.criadoEm;
    data['atualizado_em'] = this.atualizadoEm;
    return data;
  }
}

class Status {
  String descricao;
  String criadoEm;
  int id;

  Status({this.descricao, this.criadoEm, this.id});

  Status.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    criadoEm = json['criado_em'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descricao'] = this.descricao;
    data['criado_em'] = this.criadoEm;
    data['id'] = this.id;
    return data;
  }
}