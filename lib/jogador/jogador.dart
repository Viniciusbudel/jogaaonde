
class Jogador {
  String id;
  String nome;
  String cpf;
  String email;
  String telefone;
  bool disponivel;
  String cep;
  String logradouro;
  int numero;
  String bairro;
  String cidade;
  String uf;
  String pais;
  bool excluido;
  String criadoEm;
  String atualizadoEm;
  int fifa_times_id;
  String senha;
  String posicao;
  double avaliacao;

  Jogador({this.id,
    this.nome,
    this.cpf,
    this.email,
    this.telefone,
    this.disponivel,
    this.cep,
    this.logradouro,
    this.numero,
    this.bairro,
    this.cidade,
    this.uf,
    this.pais,
    this.excluido,
    this.criadoEm,
    this.atualizadoEm,
    this.senha,
    this.posicao,
    this.avaliacao,
    this.fifa_times_id});

  Jogador.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    fifa_times_id = json['fifa_times_id'];
    nome = json['nome'];
    cpf = json['cpf'];
    email = json['email'];
    telefone = json['telefone'];
    disponivel = json['disponivel'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    uf = json['uf'];
    pais = json['pais'];
    excluido = json['excluido'];
    criadoEm = json['criado_em'];
    posicao = json['posicao'];
    atualizadoEm = json['atualizado_em'];

  }

  Map<String, dynamic> toJson() => {
    'nome': this.nome,
    'cpf': this.cpf,
    'email': this.email,
    'telefone': this.telefone,
    'fifa_times_id': this.fifa_times_id,
    'cep': this.cep,
    'logradouro': this.logradouro,
    'numero': this.numero,
    'bairro': this.bairro,
    'cidade': this.cidade,
    'uf': this.uf,
    'pais': this.pais,
    'senha': this.senha,
  };
}