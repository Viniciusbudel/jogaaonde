import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/jogador/adicionar_jogador/lista_jogador_page.dart';
import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_bloc.dart';
import 'package:jogaaonde/social/social_page.dart';
import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/time/time_bloc.dart';
import 'package:jogaaonde/utils/checkbox_model.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'package:jogaaonde/utils/widgets/custom_dialog.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'package:jogaaonde/utils/prefs.dart';
import 'package:jogaaonde/utils/widgets/custom_button.dart';
import 'package:jogaaonde/utils/widgets/custom_text_error.dart';
import 'package:jogaaonde/utils/widgets/custom_checkbox_field.dart';

class TimePage extends StatefulWidget {
  Time time;

  TimePage(this.time);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<TimePage> {
  String dropdownValue = "";
  IconData _icon = Icons.sentiment_neutral;
  final _formKey = GlobalKey<FormState>();
  bool showProgress = false;
  CheckBoxModel dispoParaJogosCheck =
      CheckBoxModel(texto: "Disponível para Jogos",checked: true);
  CheckBoxModel aceitaIntegrantesCheck =
      CheckBoxModel(texto: "Aceita Integrantes");

  final _timeBloc = TimeBloc();

  final _tNome = TextEditingController();
  final _tDescricao = TextEditingController();
  final _tEscudo = TextEditingController();
  final _tCidade = TextEditingController();
  final _tUf = TextEditingController();
  String id = "";
  bool visible = false;
  final _bloc = JogadorBloc();
  List<Jogador> jogadores;

  @override
  void initState() {
    _bloc.getJogadoresByTimeId(widget.time.id.toString());


    _tNome.text = widget.time.nome;
    _tDescricao.text = widget.time.descricao;
    _tCidade.text = widget.time.cidade;
    _tUf.text = widget.time.uf;

    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF04220A),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
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
                      onPressed: () {
                        push(context, SocialPage());
                      },
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
                          SizedBox(height: 4),
                          Text(
                            "Listar Jogadors",
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
              widget.time.jogador_adm.toString() == id
                  ? _camposEditarTime()
                  : Container(),
              _listTimes(),
              SizedBox(height: 40),

              //GridDashboard()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Adicionar ao Time"),
          backgroundColor: Colors.greenAccent[700],
          onPressed: () {
            push(context, ListaJogadorPage(widget.time.id.toString()));
          },
        ));
  }

  Container _camposEditarTime() {
    return Container(
      //height: double.infinity,
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          _buildNomeTF(),
          SizedBox(height: 20),
          _buildDescricao(),
          SizedBox(height: 20),
          _buildCidadeTF(),
          SizedBox(height: 20),
          _buildEstadoTF(),
          SizedBox(height: 30),
          CheckBoxField(dispoParaJogosCheck),
          SizedBox(height: 30),
          CheckBoxField(aceitaIntegrantesCheck),
          SizedBox(height: 20),
          CustomButton("ALTERAR", onClickCadastrarTime),
        ],
      ),
    );
  }

  _listTimes() {
    return StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return TextError("Não foi possivel buscar os dados!");
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          jogadores = snapshot.data;
          return RefreshIndicator(
              onRefresh: _onRefresh, child: _listViewJogadors(jogadores));
          //child: TimeListView(times, widget.origem));
        });
  }

  _configDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: Text('Adicionar Jogador ao Time'),
            content: new SingleChildScrollView(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    obscureText: true,
                    //controller: _textFieldSenhaController,
                    decoration:
                        InputDecoration(hintText: "Digite nome do jogador"),
                    //keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('Adicionar'),
                onPressed: () {
                  //_validaSenha(context, "Abre_Configuracao", ConfigPage(),"Senha inválida");
                },
              )
            ],
          );
        });
  }

  _listViewJogadors(List<Jogador> times) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: times.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(index, context);
      },
    );
  }

  Card makeCard(int index, context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.green),
        child: makeListTile(index, context),
      ),
    );
  }

  makeListTile(index, context) {
    Jogador j = jogadores[index];
    return SafeArea(
      child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text(
            j.nome,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              //Icon(Icons.assignment, color: Colors.white70),
              Text(j.nome, style: TextStyle(color: Colors.white))
            ],
          ),
          trailing: GestureDetector(
              onTap: () => null, //PartidasRecentesPage
              child: Icon(Icons.cancel, color: Colors.white, size: 30.0))),
    );
  }

  Widget _buildNomeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nome do Time',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyleGreen,
          height: 60.0,
          child: TextField(
            controller: _tNome,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.mode_edit,
                color: Colors.white,
              ),
              hintText: 'De um nome para seu time!',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCidadeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Cidade',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyleGreen,
          height: 60.0,
          child: TextField(
            controller: _tCidade,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.location_city,
                color: Colors.white,
              ),
              hintText: 'Digite cidade do seu time!',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEstadoTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Estado',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyleGreen,
          height: 60.0,
          child: TextField(
            controller: _tUf,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              hintText: 'Digite estado do seu time!',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescricao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Descrição',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyleGreen,
          height: 60.0,
          child: TextField(
            controller: _tDescricao,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.list,
                color: Colors.white,
              ),
              hintText: 'De uma descrição para seu time!',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  onClickCadastrarTime() async {
    //if (_formKey.currentState.validate()) {
    setState(() {
      showProgress = true;
    });

    var time = Time(
      id: widget.time.id,
      nome: _tNome.text,
      cidade: _tCidade.text,
      uf: _tUf.text,
      descricao: _tDescricao.text,
      escudo: "teste",
      aceitaIntegrantes: true,
    );

    final response = await _timeBloc.updtaeTime(time);

    if (response.ok) {
      DialogUtils.showCustomDialog(context,
          title: "Time Alterado com Sucesso!",
          okBtnText: "Ok",
          cancelBtnText: "",
          okBtnFunction: () => Navigator.pop(context)
          //push(context, TimesPage("home")) //Fazer algo
          //Fazer algo
          );
    } else {
      DialogUtils.showCustomDialog(context,
          title: response.msg,
          okBtnText: "Ok",
          cancelBtnText: "",
          okBtnFunction: () => Navigator.pop(context)
          //push(context, TimesPage("home")) //Fazer algo
          //Fazer algo
          );

      setState(() {
        showProgress = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _bloc.dispose();
  }

  Future<void> _onRefresh() {
    return _bloc.getJogadoresByTimeId(widget.time.id.toString());
  }

  Future<bool> _onBackPressed() async {
    push(context, HomePage());
  }

  Future<void> loadData() async {
    id = await Prefs.getString("id");

    setState(() {
      widget.time.aceitaIntegrantes ? aceitaIntegrantesCheck.checked = true : aceitaIntegrantesCheck.checked = false;

      id;
    });
  }
}
