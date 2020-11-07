import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_bloc.dart';
import 'package:jogaaonde/time/lista_times_page.dart';
import 'package:jogaaonde/time/time_bloc.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'package:jogaaonde/utils/custom_dialog.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'package:jogaaonde/utils/text_error.dart';

class ListaJogadorPage extends StatefulWidget {
  String idTime;

  ListaJogadorPage(this.idTime);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ListaJogadorPage> {
  final _bloc = JogadorBloc();
  final _tNome = TextEditingController();
  List<Jogador> clientes;

  @override
  void initState() {
    // TODO: implement initState
    //_bloc.listarJogadors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Color(0xFF05290C),
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
                        push(context, HomePage());
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
              SizedBox(height: 10),
              _rowBuscar(),
              _listJogadors(),

              //GridDashboard()
            ],
          ),
        ),
//        floatingActionButton: FloatingActionButton.extended(
//          icon: Icon(Icons.add),
//          label: Text("Cadastrar"),
//          backgroundColor: Colors.orange[700],
//          onPressed: () {
//            //push(context, CadastrarJogadorPage(null));
//          },
//        ),
      ),
    );
  }

  _listJogadors() {
    return StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return TextError("Não foi possivel buscar os dados!");
          }
          if (!snapshot.hasData) {
            return Center(
                // child: CircularProgressIndicator(),
                );
          }
          clientes = snapshot.data;
          return RefreshIndicator(
              onRefresh: _onRefresh, child: _list(clientes, widget.idTime));
        });
  }

  Padding _rowBuscar() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: kBoxDecorationStyle,
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: TextField(
                controller: _tNome,
                obscureText: false,
                style: kFieldTextStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.orange[700],
                  ),
                  hintText: "Buscar por nome",
                  hintStyle: kHintTextStyle,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.orange[400])),
                  color: Colors.orange[700],
                  onPressed: () => _bloc.getJogadoresByNomeOrEmail(_tNome.text),
                  child: Text(
                    "Buscar",
                    style: GoogleFonts.lato(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _bloc.dispose();
  }

  Future<void> _onRefresh() {
    //return _bloc.listarJogadors();
  }

  Future<bool> _onBackPressed() async {
    push(context, HomePage());
  }

  _list(List<Jogador> clientes, String idTime) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: clientes.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(index, context);
      },
    );
  }

  makeListTile(index, context) {
    Jogador c = clientes[index];
    return GestureDetector(
      onTap: () => _onClickList(context, c),
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.person_outline, color: Colors.white),
          ),
          title: Text(
            c.nome != null ? c.nome : '',
            style: GoogleFonts.lato(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: GoogleFonts.lato(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              //Icon(Icons.assignment, color: Colors.white70),
              Text(c.email, style: GoogleFonts.lato(color: Colors.white))
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0)),
    );
  }

  Card makeCard(int index, context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(index, context),
      ),
    );
  }

  _onClickList(context, Jogador j) async {
    final _bloc = TimeBloc();
    final response = await _bloc.addJogadorTime(j.id, widget.idTime);

    if (response.ok) {
      DialogUtils.showCustomDialog(context,
          title: response.msg,
          okBtnText: "Ok",
          cancelBtnText: "",
          okBtnFunction: () => push(context, ListarTimePage("home")) //Fazer algo
          //Fazer algo
          );
    } else {
      DialogUtils.showCustomDialog(context,
          title: response.msg,
          okBtnText: "Ok",
          cancelBtnText: "",
          okBtnFunction: () => Navigator.pop(context)
          //push(context, JogadorsPage("home")) //Fazer algo
          //Fazer algo
          );
    }
  }
}
