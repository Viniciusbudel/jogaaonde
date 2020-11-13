import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/time/lista_times_page.dart';
import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/time/time_bloc.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'file:///C:/Users/softwar02/AndroidStudioProjects/jogaaonde/lib/utils/widgets/custom_dialog.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'package:jogaaonde/utils/prefs.dart';
import 'file:///C:/Users/softwar02/AndroidStudioProjects/jogaaonde/lib/utils/widgets/custom_text_error.dart';
import 'package:jogaaonde/utils/widgets/custom_search_row.dart';

class ListarTimesProximosPage extends StatefulWidget {
  @override
  _ListarTimesProximosPageState createState() =>
      _ListarTimesProximosPageState();
}

class _ListarTimesProximosPageState extends State<ListarTimesProximosPage> {
  final _bloc = TimeBloc();
  List<Time> times;
  String id = "";
  final _tNome = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _bloc.listarTimesByCidade("Curitiba");

    loadData();
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
                              "Listar Time",
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
                CustomSearchRow("Buscar por Cidade", _tNome, _onClickSearch),
                _listTimes(),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
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
          times = snapshot.data;
          return RefreshIndicator(
              onRefresh: _onRefresh, child: _listViewTimes(times));
          //child: TimeListView(times, widget.origem));
        });
  }

  _listViewTimes(List<Time> times) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: times.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(index, context);
      },
    );
  }

  makeListTile(index, context) {
    Time c = times[index];
    return GestureDetector(
      onTap: () => _onClickTime(c),
      child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(
                c.jogador_adm.toString() == id
                    ? Icons.grade_sharp
                    : Icons.person,
                color: Colors.white),
          ),
          title: Text(
            c.nome,
            style: GoogleFonts.lato(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: GoogleFonts.lato(color: Colors.white)),

          subtitle: Text(
            c.descricao,
            style: GoogleFonts.lato(
                color: Colors.white, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0)),
    );
  }

  Card makeCard(int index, context) {
    Time c = times[index];

    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
            color: c.jogador_adm.toString() == id
                ? Colors.green[600]
                : Colors.green[900]),
        child: makeListTile(index, context),
      ),
    );
  }

  _onClickSearch(){
    _bloc.listarTimesByCidade(_tNome.text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _bloc.dispose();
  }

  Future<void> _onRefresh() {
    return _bloc.listarTimesByCidade("Curitiba");
  }

  Future<bool> _onBackPressed() async {
    push(context, HomePage());
  }

  Future<void> loadData() async {
    id = await Prefs.getString("id");
  }

  _onClickTime(Time time) async {
    // switch (widget.origem) {
    //   case "campeonato":
    _showDialogEntrarTime(time);
    //     break;
    //   case "home":
    //     push(context, TimePage(time));
    //     break;
    //   case "partidasRecentes":
    //     push(context, ListaPartidasRecentesPage(time));
    //     break;
    // }
  }

  Future _joinTime(Time time) async {
    id = await Prefs.getString("id");

    final response = await _bloc.addJogadorTime(id, time.id);

    if (response.ok) {
      DialogUtils.showCustomDialog(context,
          title: response.msg,
          okBtnText: "Ok",
          cancelBtnText: "",
          okBtnFunction: () =>
              push(context, ListarTimePage("home")) //Fazer algo
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

  void _showDialogEntrarTime( Time c) {
    DialogUtils.showCustomDialog(
      context,
      title: "Deseja juntar-se ao time?",
      okBtnText: "Ok",
      cancelBtnText: "",
      okBtnFunction: () => _joinTime(c),
    );
  }
}
