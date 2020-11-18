import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/campeonato/campeonato.dart';
import 'package:jogaaonde/campeonato/campeonato_bloc.dart';
import 'package:jogaaonde/campeonato/campeonato_chaves.dart';
import 'package:jogaaonde/campeonato/campeonato_page.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/time/lista_times_page.dart';
import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/time/time_bloc.dart';
import 'package:jogaaonde/time/time_page.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'package:jogaaonde/utils/prefs.dart';
import 'package:jogaaonde/utils/widgets/custom_card_column.dart';
import 'package:jogaaonde/utils/widgets/custom_card_row.dart';
import 'package:jogaaonde/utils/widgets/custom_text_error.dart';

class ListarCampeonato8ChavePage extends StatefulWidget {
  CampeonatoChaves campeonatoChaves;

  ListarCampeonato8ChavePage(this.campeonatoChaves);

  @override
  _ListarCampeonato8ChavePageState createState() =>
      _ListarCampeonato8ChavePageState();
}

class _ListarCampeonato8ChavePageState
    extends State<ListarCampeonato8ChavePage> {
  List<Campeonato> times;
  String id = "";
  final _tNome = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
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
                          push(context, CampeonatoPage());
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
                buildChave(),
                SizedBox(height: 5),
                widget.campeonatoChaves.nivel2 != null
                    ? buildChave2()
                    : buildChaveIncompleta(),
                widget.campeonatoChaves.nivel3 != null
                    ? buildChave3()
                    : buildChaveIncompleta(),
                widget.campeonatoChaves.nivel4 != null
                    ? buildChave4()
                    : buildChaveIncompleta(),

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

  buildChave() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
        color: Colors.green[300],
        child: Column(
          children: [
            Text("Chave 1",
                style: GoogleFonts.lato(color: Colors.black, fontSize: 20)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 47,
                    child: CustomCardRow("Time 1",
                        widget.campeonatoChaves.nivel1[0].timeAnfitriaoNome)),
                Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "X",
                            style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.campeonatoChaves.nivel1[0].resultado ?? "Não ocorreu ainda",
                            style: GoogleFonts.lato(color: Colors.red, fontSize: 11),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 47,
                    child: CustomCardRow("Time 2",
                        widget.campeonatoChaves.nivel1[0].timeConvidadoNome)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 47,
                    child: CustomCardRow("Time 1",
                        widget.campeonatoChaves.nivel1[1].timeAnfitriaoNome)),
                Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "X",
                            style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.campeonatoChaves.nivel1[1].resultado ?? "Não ocorreu ainda",
                            style: GoogleFonts.lato(color: Colors.red, fontSize: 11),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 47,
                    child: CustomCardRow(
                        "Time 2",
                        widget.campeonatoChaves.nivel1[1].timeConvidadoNome +
                            "\n")),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 47,
                    child: CustomCardRow("Time 1",
                        widget.campeonatoChaves.nivel1[2].timeAnfitriaoNome)),
                Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "X",
                            style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.campeonatoChaves.nivel1[2].resultado ?? "Não ocorreu ainda",
                            style: GoogleFonts.lato(color: Colors.red, fontSize: 11),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 47,
                    child: CustomCardRow(
                        "Time 2",
                        widget.campeonatoChaves.nivel1[2].timeConvidadoNome +
                            "\n")),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 47,
                    child: CustomCardRow("Time 1",
                        widget.campeonatoChaves.nivel1[3].timeAnfitriaoNome)),
                Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "X",
                            style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.campeonatoChaves.nivel1[3].resultado ?? "Não ocorreu ainda",
                            style: GoogleFonts.lato(color: Colors.red, fontSize: 11),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 47,
                    child: CustomCardRow(
                        "Time 2",
                        widget.campeonatoChaves.nivel1[3].timeConvidadoNome +
                            "\n")),
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  buildChave2() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
        color: Colors.green[300],
        child: Column(
          children: [
            Text("Chave 2",
                style: GoogleFonts.lato(color: Colors.black, fontSize: 20)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 47,
                    child: CustomCardRow("Time 1",
                        widget.campeonatoChaves.nivel2[0].timeAnfitriaoNome)),
                Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "X",
                            style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.campeonatoChaves.nivel2[0].resultado ?? "Não ocorreu ainda",
                            style: GoogleFonts.lato(color: Colors.red, fontSize: 11),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 47,
                    child: CustomCardRow("Time 2",
                        widget.campeonatoChaves.nivel2[0].timeConvidadoNome)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 47,
                    child: CustomCardRow("Time 1",
                        widget.campeonatoChaves.nivel2[1].timeAnfitriaoNome)),
                Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "X",
                            style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.campeonatoChaves.nivel2[1].resultado ?? "Não ocorreu ainda",
                            style: GoogleFonts.lato(color: Colors.red, fontSize: 11),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 47,
                    child: CustomCardRow(
                        "Time 2",
                        widget.campeonatoChaves.nivel2[1].timeConvidadoNome +
                            "\n")),
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  buildChaveIncompleta() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
        color: Colors.green[300],
        child: Column(
          children: [
            Text("Chave 2",
                style: GoogleFonts.lato(color: Colors.black, fontSize: 20)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 47, child: CustomCardRow("Time 1", "????")),
                Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "X",
                            style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.campeonatoChaves.nivel3[0].resultado ?? "Não ocorreu ainda",
                            style: GoogleFonts.lato(color: Colors.red, fontSize: 11),
                          ),
                        ),
                      ],
                    )),
                Expanded(flex: 47, child: CustomCardRow("Time 2", "????")),
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  buildChave3() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
        color: Colors.green[300],
        child: Column(
          children: [
            Text("Chave 3",
                style: GoogleFonts.lato(color: Colors.black, fontSize: 20)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 47,
                    child: CustomCardRow("Time 1",
                        widget.campeonatoChaves.nivel3[0].timeAnfitriaoNome)),
                Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "X",
                            style: GoogleFonts.lato(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.campeonatoChaves.nivel3[0].resultado ?? "Não ocorreu ainda",
                            style: GoogleFonts.lato(color: Colors.red, fontSize: 11),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 47,
                    child: CustomCardRow("Time 2",
                        widget.campeonatoChaves.nivel3[0].timeConvidadoNome)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  buildChave4() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
        color: Colors.green[300],
        child: Column(
          children: [
            Text("Campeão",
                style: GoogleFonts.lato(color: Colors.black, fontSize: 20)),
            CustomCardColumn(
                "Campeão", widget.campeonatoChaves.nivel4[0].timeAnfitriaoNome),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    push(context, CampeonatoPage());
  }

  Future<void> loadData() async {
    id = await Prefs.getString("id");
  }
}
