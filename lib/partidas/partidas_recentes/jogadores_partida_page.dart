import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_bloc.dart';
import 'package:jogaaonde/partidas/partidas_recentes/avaliacao_jogador.dart';
import 'package:jogaaonde/partidas/partidas_recentes/partidas_recentes_api.dart';
import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'file:///C:/Users/softwar02/AndroidStudioProjects/jogaaonde/lib/utils/widgets/custom_text_error.dart';
import 'package:jogaaonde/utils/widgets/custom_button.dart';

class JodadoresPartidasPage extends StatefulWidget {
  Time time;
  int idPartida;

  JodadoresPartidasPage(this.time, this.idPartida);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<JodadoresPartidasPage> {
  String dropdownValue = "";
  IconData _icon = Icons.sentiment_neutral;
  List<Jogador> jogadores;
  final _bloc = JogadorBloc();

  @override
  void initState() {
    _bloc.getJogadoresByTimeId(widget.time.id.toString());

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
            _listPartidasRecentess(),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: CustomButton("CADASTRAR", _onClickConfirmarAvalicao),
            )
            //GridDashboard()
          ],
        ),
      ),
    );
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
          jogadores = snapshot.data;
          return RefreshIndicator(
              onRefresh: _onRefresh,
              child: _listViewPartidasRecentess(jogadores));
          //child: PartidasRecentesListView(quadras, widget.origem));
        });
  }

  _listViewPartidasRecentess(List<Jogador> jogadores) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: jogadores.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(index);
      },
    );
  }

  makeListTile(Jogador jogador) {
    try {
      return GestureDetector(
        //onTap: () => _onClickPartRecente(),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.sports_soccer, color: Colors.white),
          ),
          title: Text(
            jogador.nome,
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
                    jogador.posicao,
                    style: GoogleFonts.lato(fontSize: 16),
                  ),
                ],
              )),
          trailing: _iconAvaliacao(jogador),
          onTap: () => _rateDialog(context, jogador),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Icon _iconAvaliacao(Jogador jogador) {
    try {
      if (jogador.avaliacao == null) {
        return Icon(Icons.sentiment_neutral, color: Colors.white, size: 30.0);
      } else {
        switch (jogador.avaliacao.toString()) {
          case "1.0":
            return Icon(Icons.sentiment_very_dissatisfied,
                color: Colors.white, size: 30.0);

            break;
          case "2.0":
            return Icon(Icons.sentiment_dissatisfied,
                color: Colors.white, size: 30.0);

            break;
          case "3.0":
            return Icon(Icons.sentiment_neutral,
                color: Colors.white, size: 30.0);

            break;
          case "4.0":
            return Icon(Icons.sentiment_satisfied,
                color: Colors.white, size: 30.0);

            break;
          case "5.0":
            return Icon(Icons.sentiment_very_satisfied,
                color: Colors.white, size: 30.0);
            break;
          default:
            return Icon(Icons.sentiment_neutral,
                color: Colors.white, size: 30.0);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  makeCard(index) {
    Jogador jogador = jogadores[index];
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: GestureDetector(
        onTap: () => print('Clicado'),
        child: Container(
          decoration: BoxDecoration(color: Colors.green),
          child: makeListTile(jogador),
        ),
      ),
    );
  }

  _rateDialog(BuildContext context, jogador) async {
    try {
      return showDialog(
          context: context,
          builder: (context) {
            return new AlertDialog(
              title: Text('Avalie Jogador'),
              content: RatingBar.builder(
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
                    jogador.avaliacao = rating;
                  }),
              actions: [
                FlatButton(
                  child: Text("Ok",
                      style: GoogleFonts.lato(color: Colors.deepOrange)),
                  onPressed: () => _okBtnFunction(jogador),
                )
              ],
            );
          });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onRefresh() {
    return _bloc.getJogadoresByTimeId(widget.time.id.toString());
  }

  Future<bool> _onBackPressed() async {
    push(context, HomePage());
  }

  _okBtnFunction(jogador) {
    Navigator.of(this.context).pop();

    setState(() {
      jogador;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _bloc.dispose();
  }

  _onClickConfirmarAvalicao() {
    try {
      List<AvaliacaoJogador> avaliacoesJogador = List();

      jogadores.forEach((element) {
        AvaliacaoJogador avaliacaoJogador = AvaliacaoJogador();

        avaliacaoJogador.jogadorId = int.parse(element.id);
        avaliacaoJogador.nota = element.avaliacao.toInt();

        avaliacoesJogador.add(avaliacaoJogador);
      });

      PartidasRecentesApi.insertAvaliacaoJogador(
          avaliacoesJogador, widget.idPartida.toString());
    } catch (e) {
      print(e);
    }
  }
}
