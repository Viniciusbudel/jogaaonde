import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/partidas/partidas_recentes/jogadores_partida_page.dart';
import 'package:jogaaonde/partidas/partidas_recentes/partidas_recentes_api.dart';
import 'package:jogaaonde/partidas/marcar_partida/selecionar_data_page.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/quadra/quadra_bloc.dart';
import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'package:jogaaonde/utils/widgets/custom_dialog.dart';
import 'package:jogaaonde/utils/widgets/custom_text_error.dart';
import 'package:jogaaonde/utils/widgets/custom_button.dart';

class AvaliarQuadraPage extends StatefulWidget {
  Quadra quadra;
  Time time;
  int idPartida;

  AvaliarQuadraPage(this.quadra, this.time, this.idPartida);

  @override
  _AvaliarQuadraPageState createState() => _AvaliarQuadraPageState();
}

class _AvaliarQuadraPageState extends State<AvaliarQuadraPage> {
  final _bloc = QuadraBloc();
  List<Quadra> quadras;
  final _tNome = TextEditingController();

  int ratingAtual = 0;

  @override
  void initState() {
    // TODO: implement initState
    // _bloc.getQuadraById(widget.empresa.id.toString());
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
                              "Avaliar Quadra",
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
                makeCard(),
                SizedBox(height: 10),
                _avaliacao(),
                SizedBox(height: 10),
                CustomButton("AVALIAR", asyncFunc)
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

  _avaliacao() {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        ratingAtual = rating.toInt();
        print(rating);
      },
    );
  }

  makeCard() {
    Quadra quadra = widget.quadra;
    return Container(
      padding: EdgeInsets.all(8),
      child: GestureDetector(
        //onTap: () => push(context, SelecionarData(widget.idTime, quadra.id.toString())),
        child: Card(
          color: Color(0xFF05290C),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1),
              side: BorderSide(color: Colors.white, width: 0.1)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              quadra.imagem != null
                  ? Image.network(
                      quadra.imagem,
                      width: 150,
                      height: 100,
                      fit: BoxFit.fill,
                    )
                  : Container(),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            quadra.descricao,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(
                            quadra.possuiCobertura
                                ? "Quadra Coberta"
                                : "Quadra Aberta",
                            style: GoogleFonts.lato(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
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

  Future<bool> _onBackPressed() async {
    push(context, HomePage());
  }

  Future<void> asyncFunc() async {
    final response = await PartidasRecentesApi.insertAvaliacaoQuadra(
        ratingAtual, widget.idPartida);

    if (response.ok) {
      push(context, JodadoresPartidasPage(widget.time, widget.idPartida));
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
