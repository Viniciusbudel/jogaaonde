import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/empresa/empresa_bloc.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/marcar_partida/selecionar_data_page.dart';
import 'package:jogaaonde/partidas_recentes/jogadores_partida_page.dart';
import 'package:jogaaonde/partidas_recentes/partidas_recentes.dart';
import 'package:jogaaonde/partidas_recentes/partidas_recentes_bloc.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/quadra/quadra_bloc.dart';
import 'package:jogaaonde/quadra/quadra_page.dart';
import 'package:jogaaonde/social/social_page.dart';
import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'package:jogaaonde/utils/text_error.dart';

class ListaPartidasRecentesPage extends StatefulWidget {
  Time time;

  ListaPartidasRecentesPage(this.time);

  @override
  _ListaPartidasRecentesPageState createState() =>
      _ListaPartidasRecentesPageState();
}

class _ListaPartidasRecentesPageState extends State<ListaPartidasRecentesPage> {
  final _bloc = PartidasRecentesBloc();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
  DateFormat hourFormat = DateFormat("HH:mm:ss");
  List<PartidasRecentes> quadras;

  @override
  void initState() {
    // TODO: implement initState
    _bloc.getPartidasRecentesByTime(widget.time.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
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
                              "Listar Partidas Recentes",
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
                _listPartidasRecentess(),

                //GridDashboard()
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  _listPartidasRecentess() {
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
          quadras = snapshot.data;
          return RefreshIndicator(
              onRefresh: _onRefresh,
              child: _listViewPartidasRecentess(quadras));
          //child: PartidasRecentesListView(quadras, widget.origem));
        });
  }

  _listViewPartidasRecentess(List<PartidasRecentes> quadras) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: quadras.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(index, context);
      },
    );
  }

  makeListTile(index, context) {
    PartidasRecentes partRecentes = quadras[index];
    return GestureDetector(
      onTap: () => _onClickPartRecente(),
      child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          isThreeLine: true,
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.sports_soccer, color: Colors.white),
          ),
          title: Text(
            partRecentes.descricao,
            //c.ordemServico,
            style: GoogleFonts.lato(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Container(
              padding: EdgeInsets.only(top: 2),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    partRecentes.quadra_descricao,
                    style: GoogleFonts.lato(fontSize: 14),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      _txtData(partRecentes),
                      style: GoogleFonts.acme(fontSize: 15),
                    ),
                  ),
                ],
              )),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0)),
    );
  }

  String _txtData(PartidasRecentes partRecentes) {
    var dataAbertura = DateTime.parse(partRecentes.data_abertura);
    var dataFechamento = DateTime.parse(partRecentes.data_fechamento);

    String dt_abertura = dateFormat.format(dataAbertura);
    String dt_fechamento = hourFormat.format(dataFechamento);

    return "$dt_abertura - $dt_fechamento";
  }

  Card makeCard(int index, context) {
    PartidasRecentes c = quadras[index];

    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.green),
        child: makeListTile(index, context),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  Future<void> _onRefresh() {
    return _bloc.getPartidasRecentesByTime(widget.time.id.toString());
  }

  Future<bool> _onBackPressed() async {
    push(context, SocialPage());
  }

  _onClickPartRecente() {
    push(context, JodadoresPartidasPage(widget.time));

  }
}
