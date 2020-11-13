import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/campeonato/lista_campeonatos_page.dart';
import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/empresa/empresa_bloc.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'file:///C:/Users/softwar02/AndroidStudioProjects/jogaaonde/lib/partidas/marcar_partida/selecionar_data_page.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/quadra/quadra_bloc.dart';
import 'package:jogaaonde/quadra/quadra_page.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'file:///C:/Users/softwar02/AndroidStudioProjects/jogaaonde/lib/utils/widgets/custom_text_error.dart';

class CampeonatoPage extends StatefulWidget {
  CampeonatoPage();

  @override
  _CampeonatoPageState createState() => _CampeonatoPageState();
}

class _CampeonatoPageState extends State<CampeonatoPage> {
  bool showProgressInscrever = false;
  bool showProgressConsultar = false;

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        //resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xFF05290C),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 5, child: Container()),
            Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      alignment: Alignment.topCenter,
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white70,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Column(
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
                          "Campeonatos",
                          style: GoogleFonts.lato(
                              color: Color(0xffa29aac),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(flex: 20,child: Container()),
            Expanded(
              flex: 65,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildCardInscrever(),
                    SizedBox(height: 20),
                    _buildCardConsultar(),
                  ],
                ),
              ),
            )
          ],
        ),
      );
      ;
    } catch (e) {
      print(e);
    }
  }

  Widget _buildCardInscrever() {
    return Container(
      height: 160,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      width: double.infinity,
      child: Card(
        color: Colors.green[400],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: RaisedButton(
          color: Colors.green[400],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          elevation: 5.0,
          onPressed: () =>
              !showProgressInscrever ? _onClickCardInscrever() : null,
          padding: EdgeInsets.all(15.0),
          child: !showProgressInscrever
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Icon(
                        Icons.assignment,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Inscrever-se",
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          letterSpacing: 1.3,
                          fontSize: 21.0,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildCardConsultar() {
    return Container(
      height: 160,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      width: double.infinity,
      child: Card(
        color: Colors.green[400],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: RaisedButton(
          color: Colors.green[400],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          elevation: 5.0,
          onPressed: () =>
              !showProgressConsultar ? _onClickCardConsultar() : null,
          padding: EdgeInsets.all(15.0),
          child: !showProgressConsultar
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Icon(
                        Icons.arrow_right_alt_sharp,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Seus Campeonatos",
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          letterSpacing: 1.3,
                          fontSize: 21.0,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
        ),
      ),
    );
  }

  _onClickCardInscrever() {
    push(context, ListarCampeonatoPage());
  }

  _onClickCardConsultar() {}
}
