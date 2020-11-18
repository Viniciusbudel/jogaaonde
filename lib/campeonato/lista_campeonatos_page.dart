import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/campeonato/campeonato.dart';
import 'package:jogaaonde/campeonato/campeonato_bloc.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/time/lista_times_page.dart';
import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/time/time_bloc.dart';
import 'package:jogaaonde/time/time_page.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'package:jogaaonde/utils/prefs.dart';
import 'package:jogaaonde/utils/widgets/custom_text_error.dart';

class ListarCampeonatoPage extends StatefulWidget {


  @override
  _ListarCampeonatoPageState createState() => _ListarCampeonatoPageState();
}

class _ListarCampeonatoPageState extends State<ListarCampeonatoPage> {
  final _bloc = CampeonatoBloc();
  List<Campeonato> times;
  String id = "";
  final _tNome = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _bloc.getCampeonatoByCidade("Curitiba");

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
                              "Listar Campeonato",
                              style: GoogleFonts.lato(
                                  color: Color(0xffa29aac),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      //                    IconButton(
                      //                      alignment: Alignment.topCenter,
                      //                      icon: Icon(Icons.list),
                      //                      color: Colors.white70,
                      //                      onPressed: () {},
                      //                    )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                _listCampeonatos(),

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

  _listCampeonatos() {
    return StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return TextError("Nenhum registro encontrado!");
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          times = snapshot.data;
          return RefreshIndicator(
              onRefresh: _onRefresh, child: _listViewCampeonatos(times));
          //child: CampeonatoListView(times, widget.origem));
        });
  }

  _listViewCampeonatos(List<Campeonato> times) {
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
    Campeonato c = times[index];
    return GestureDetector(
      onTap: () => push(context, ListarTimePage("campeonato",idCampeonato: c.id.toString(),)),
      child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Image.asset("assets/images/campeonato_128.png",width: 42,),
          ),
          title: Text(
            c.nome,
            style: GoogleFonts.lato(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: GoogleFonts.lato(color: Colors.white)),



          subtitle: Text(
            c.descricao +"\nParticipantes "+c.qtdParticipantes.toString(),
            style: GoogleFonts.lato(
                color: Colors.white, fontWeight: FontWeight.normal),
          ),
          isThreeLine: true,

          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0)),
    );
  }

  Card makeCard(int index, context) {
    Campeonato c = times[index];

    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.green[600]),
        child: makeListTile(index, context),
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
    return _bloc.getCampeonatoByCidade("Curitiba");
  }

  Future<bool> _onBackPressed() async {
    push(context, HomePage());
  }

  Future<void> loadData() async {
    id = await Prefs.getString("id");
  }
}
