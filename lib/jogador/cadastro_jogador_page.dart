import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_bloc.dart';
import 'package:jogaaonde/login/login_page.dart';
import 'package:jogaaonde/social/social_page.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'package:jogaaonde/utils/custom_dialog.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'package:via_cep/via_cep.dart';

class CadastrarJogadorPage extends StatefulWidget {
  Jogador jogador;

  CadastrarJogadorPage(this.jogador);

  //TextEditingController nomeInputController = new TextEditingController();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CadastrarJogadorPage> {
  String dropdownValue;
  final _formKey = GlobalKey<FormState>();

  bool showProgress = false;

  final _jogadorBloc = JogadorBloc();

  final _tNome = TextEditingController();
  final _tCpf = TextEditingController();
  final _tCep = TextEditingController();
  final _tCidade = TextEditingController();
  final _tUf = TextEditingController();
  final _tBairro = TextEditingController();
  final _tLogradouro = TextEditingController();
  final _tTelefone = TextEditingController();
  final _tEmail = TextEditingController();
  final _tNumero = TextEditingController();
  final _tSenha = TextEditingController();
  final _tPais = TextEditingController();
  final _tConfirmarSenha = TextEditingController();

  bool visible = false;
  String hintInscOuRg = "Selecione o RG do jogador";
  String textInscOuRG = "RG";

  @override
  void initState() {
    // TODO: implement initState
     if (widget.jogador != null) {
       _loadData();
     }
    super.initState();
  }

  void _loadData() {
     _tNome.text = widget.jogador.nome;
     _tCpf.text = widget.jogador.cpf;
     _tCep.text = widget.jogador.cep;
     _tCidade.text = widget.jogador.cidade;
     _tUf.text = widget.jogador.uf;
     _tBairro.text = widget.jogador.bairro;
     _tLogradouro.text = widget.jogador.logradouro;
     _tTelefone.text = widget.jogador.telefone;
     _tEmail.text = widget.jogador.email;
     _tNumero.text = widget.jogador.numero.toString();
     //_tSenha.text = widget.jogador.nome;
     _tPais.text = widget.jogador.pais;
     //_tConfirmarSenha.text = widget.jogador.senha;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Color(0xFF05290C),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      alignment: Alignment.topCenter,
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white70,
                      onPressed: () =>
                        _onBackPressed()
                      ,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Joga Aonde",
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Cadastro ",
                            style: GoogleFonts.lato(
                                color: Color(0xffa29aac),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _buildTF(
                        "Jogador",
                        "Digite o nome do jogador",
                        Icons.person_outline,
                        _tNome,
                      ),
                      SizedBox(height: 20),
                      _buildTF(
                        "CPF/CNPJ",
                        "Digite o CPF do jogador",
                        Icons.contact_mail,
                        _tCpf,
                        cpf: true,
                      ),
                      SizedBox(height: 20),
                      _buildTF("CEP", "Digite o CEP do jogador",
                          Icons.gps_fixed, _tCep,
                          cep: true),
                      SizedBox(height: 20),
                      _buildTF(
                        "País",
                        "Digite o país jogador",
                        Icons.landscape,
                        _tPais,
                      ),
                      SizedBox(height: 20),
                      _buildTF(
                        "Cidade",
                        "Digite a Cidade do jogador",
                        Icons.location_city,
                        _tCidade,
                      ),
                      SizedBox(height: 20),
                      _buildTF(
                        "UF",
                        "Selecione a UF do jogador",
                        Icons.location_on,
                        _tUf,
                      ),
                      SizedBox(height: 20),
                      _buildTF(
                        "Bairro",
                        "Digite o bairro do jogador",
                        Icons.location_city,
                        _tBairro,
                      ),
                      SizedBox(height: 20),
                      _buildTF(
                        "Endereço",
                        "Digite o endereço do jogador",
                        Icons.location_on,
                        _tLogradouro,
                      ),
                      SizedBox(height: 20),
                      _buildTF(
                        "Numero",
                        "Digite o numero do endereço do jogador",
                        Icons.location_on,
                        _tNumero,
                      ),
                      SizedBox(height: 20),
                      _buildTF(
                        "Fone",
                        "Digite telefone do jogador",
                        Icons.phone,
                        _tTelefone,
                      ),
                      SizedBox(height: 20),
                      _buildTF(
                        "E-mail",
                        "Digite seu e-mail",
                        Icons.email,
                        _tEmail,
                      ),
                      SizedBox(height: 20),
                      _buildTF(
                        "Senha",
                        "Digite a senha do jogador",
                        Icons.vpn_key,
                        _tSenha,
                      ),

                      SizedBox(height: 20),
                      _buildTF(
                        "Confirmar senha",
                        "Digite senha do jogador",
                        Icons.vpn_key,
                        _tConfirmarSenha,
                      ),
                      SizedBox(height: 20),
                      _buildCadastroBtn(),
                      //widget.jogador != null ? _listVeiculos() : Container()
                    ],
                  ),
                ),
              )
              //GridDashboard()
            ],
          ),
        ),
        // floatingActionButton: Visibility(
        //   child: FloatingActionButton.extended(
        //     icon: Icon(
        //       Icons.add,
        //       color: Colors.deepOrange,
        //     ),
        //     label: Icon(
        //       Icons.directions_car,
        //       color: Colors.deepOrange,
        //     ),
        //     backgroundColor: Colors.white,
        //     onPressed: () {
        //       push(
        //           context,
        //           CadastrarVeiculoPage(
        //               widget.jogador != null ? widget.jogador : null, null));
        //     },
        //   ),
        //   visible: widget.jogador != null ? true : false,
        // ),
      ),
    );
  }

  Widget _buildTF(String titulo, String hint, IconData icone,
      TextEditingController controller,
      {bool cep = false, bool cpf = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          titulo,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationRequiredStyle,
          height: 60.0,
          child: Focus(
            child: TextFormField(
              validator: (text) => _validar(text, cpf),
              controller: controller,
              obscureText: false,
              style: kFieldGreenTextStyle,
              decoration: InputDecoration(
                errorStyle: GoogleFonts.lato(
                  color: Colors.white,
                  backgroundColor: Colors.red,
                  fontSize: 10.0,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0, right: 8),
                prefixIcon: Icon(
                  icone,
                  color: Colors.green[700],
                ),
                hintText: hint,
                hintStyle: kHintGreenTextStyle,
              ),
            ),
            onFocusChange: (hasFocus) {
              if (!hasFocus) {
                _onFocus(cpf, cep);
              }
            },
          ),
        ),
      ],
    );
  }

  String _validar(String value, bool cpf) {
    if (value.isEmpty) {
      return ' Digite algo, por favor!';
    }
    if (cpf) {
      if (!CPF.isValid(CPF.format(value))) {
        return " Este CPF é inválido.";
      }
    }
  }

  Widget _buildCadastroBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => showProgress ? null : onClickCadastrarJogador(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: !showProgress
            ? Text(
          'SALVAR',
          style: GoogleFonts.lato(
            color: Colors.deepOrange[400],
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
            : Center(
          child: CircularProgressIndicator(
            valueColor:
            new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
          ),
        ),
      ),
    );
  }

  onClickCadastrarJogador() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        showProgress = true;
      });


      var jogador = Jogador(
        nome: _tNome.text,
       cpf: _tCpf.text
           .replaceAll(".", "")
           .replaceAll("-", "")
           .replaceAll("/", ""),
        cep: _tCep.text,
        bairro: _tBairro.text,
        cidade: _tCidade.text,
        email: _tEmail.text,
        fifa_times_id: 1,
        logradouro: _tLogradouro.text,
        telefone: _tTelefone.text,
        uf: _tUf.text,
        senha: _tSenha.text,
        pais: _tPais.text,
        numero: int.parse(_tNumero.text),
      );
      ApiResponse<Jogador> response;

      if (widget.jogador != null){
         response = await _jogadorBloc.atualizarJogador(jogador);
      }else{
         response = await _jogadorBloc.inserirJogador(jogador);
      }

      if (response.ok) {
        DialogUtils.showCustomDialog(
            context,
            title: "Jogador Cadastrado com Sucesso!",
            okBtnText: "Ok",
            cancelBtnText: "",
            okBtnFunction: () => push(context, HomePage())
          //push(context, JogadorsPage("home")) //Fazer algo
          //Fazer algo
        );
      } else {
        DialogUtils.showCustomDialog(
            context,
            title: response.msg,
            okBtnText: "Ok",
            cancelBtnText: "",
            okBtnFunction: () => Navigator.pop(context)
          //push(context, JogadorsPage("home")) //Fazer algo
          //Fazer algo
        );

        setState(() {
          showProgress = false;
        });
      }
    }
  }

  _onFocus(bool cpf, bool cep) {
    if (cpf) {
      setState(() {
        _tCpf.text = CPF.format(_tCpf.text);
      });
    } else if (cep) {
      buscaCep();
    }
  }

  buscaCep() async {
    var CEP = new via_cep();

    var result = await CEP.searchCEP(_tCep.text, 'json', '');

    // Sucesso
    if (CEP.getResponse() == 200) {
      setState(() {
        _tLogradouro.text = CEP.getLogradouro();
        _tUf.text = CEP.getUF();
        _tCidade.text = CEP.getLocalidade();
        _tBairro.text = CEP.getBairro();
        _tPais.text = "Brasil";
      });
      print('CEP: ' + CEP.getCEP());
      print('Logradouro: ' + CEP.getLogradouro());
      print('Complemento: ' + CEP.getComplemento());
      print('Bairro: ' + CEP.getBairro());
      print('Localidade: ' + CEP.getLocalidade());
      print('UF: ' + CEP.getUF());
      print('Unidade: ' + CEP.getUnidade());
      print('IBGE ' + CEP.getIBGE());
      print('GIA: ' + CEP.getGIA());
    } else {
      print('Código de Retorno: ' + CEP.getResponse().toString());
      print('Erro: ' + CEP.getBody());
    }
  }

  Future<bool> _onBackPressed() async {
    if (widget.jogador != null){
      push(context, SocialPage()); //Fazer algo

    }else{
      push(context, LoginScreen()); //Fazer algo

    }
  }
}
