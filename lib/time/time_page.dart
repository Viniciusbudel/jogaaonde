import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/jogador/adicionar_jogador/lista_jogador_page.dart';
import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_bloc.dart';
import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/time/time_bloc.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'package:jogaaonde/utils/custom_dialog.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'package:jogaaonde/utils/prefs.dart';
import 'package:jogaaonde/utils/text_error.dart';

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
    // TODO: implement initState
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
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Joga Aonde",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Pelada FC",
                          style: TextStyle(
                              color: Color(0xffa29aac),
                              fontSize: 14,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    IconButton(
                      alignment: Alignment.topCenter,
                      icon: Icon(Icons.list),
                      color: Colors.white70,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
//            Container(
//              padding: EdgeInsets.only(left: 16),
//              child: Row(children: <Widget>[
//                Image.asset("assets/images/novo_time_128.png"),
//                Text("",
//                    style: TextStyle(
//                        color: Color(0xffa29aac),
//                        fontSize: 14,
//                        fontFamily: 'OpenSans',
//                        fontWeight: FontWeight.w600))
//
//              ],),
//            ),
              SizedBox(
                height: 20,
              ),
              widget.time.jogador_adm.toString() == id ?
              _camposEditarTime() : Container(),
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
                  SizedBox(height: 20),
                  _buildCadastroBtn(),
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
              onTap: () => _rateDialog(context), //PartidasRecentesPage
              child: Icon(Icons.cancel, color: Colors.white, size: 30.0))),
    );
  }

  _rateDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
              title: Text('Avalie Jogador'),
              content: RatingBar(
                  initialRating: 3,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        );
                      case 1:
                        return Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent,
                        );
                      case 2:
                        return Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      case 3:
                        return Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                        );
                      case 4:
                        return Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                    }
                  },
                  onRatingUpdate: (rating) {
                    setState() => _icon = Icons.sentiment_very_satisfied;
                  }));
        });
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

  Widget _buildCadastroBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => onClickCadastrarTime(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'CADASTRAR',
          style: TextStyle(
            color: Colors.greenAccent[400],
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  onClickCadastrarTime() async {
    //if (_formKey.currentState.validate()) {
    setState(() {
      showProgress = true;
    });

    var time = Time(
      nome: _tNome.text,
      cidade: _tCidade.text,
      uf: _tUf.text,
      descricao: _tDescricao.text,
      escudo: "teste",
      aceitaIntegrantes: true,
    );

    final response = await _timeBloc.inserirTime(time);

    if (response.ok) {
      DialogUtils.showCustomDialog(context,
          title: "Time Cadastrado com Sucesso!",
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
      id;
    });
  }
}
