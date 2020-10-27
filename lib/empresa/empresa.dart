class Empresa {
  int id;
  String nomeFantasia;
  String razaoSocial;
  String cnpj;
  String telefone1;
  String telefone2;
  String email;
  String cep;
  String logradouro;
  int numero;
  String complemento;
  String bairro;
  String cidade;
  String uf;
  String pais;
  bool excluido;
  String criadoEm;
  String atualizadoEm;

  Empresa(
      {this.id,
        this.nomeFantasia,
        this.razaoSocial,
        this.cnpj,
        this.telefone1,
        this.telefone2,
        this.email,
        this.cep,
        this.logradouro,
        this.numero,
        this.complemento,
        this.bairro,
        this.cidade,
        this.uf,
        this.pais,
        this.excluido,
        this.criadoEm,
        this.atualizadoEm});

  Empresa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomeFantasia = json['nome_fantasia'];
    razaoSocial = json['razao_social'];
    cnpj = json['cnpj'];
    telefone1 = json['telefone1'];
    telefone2 = json['telefone2'];
    email = json['email'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    uf = json['uf'];
    pais = json['pais'];
    excluido = json['excluido'];
    criadoEm = json['criado_em'];
    atualizadoEm = json['atualizado_em'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome_fantasia'] = this.nomeFantasia;
    data['razao_social'] = this.razaoSocial;
    data['cnpj'] = this.cnpj;
    data['telefone1'] = this.telefone1;
    data['telefone2'] = this.telefone2;
    data['email'] = this.email;
    data['cep'] = this.cep;
    data['logradouro'] = this.logradouro;
    data['numero'] = this.numero;
    data['complemento'] = this.complemento;
    data['bairro'] = this.bairro;
    data['cidade'] = this.cidade;
    data['uf'] = this.uf;
    data['pais'] = this.pais;
    data['excluido'] = this.excluido;
    data['criado_em'] = this.criadoEm;
    data['atualizado_em'] = this.atualizadoEm;
    return data;
  }
}