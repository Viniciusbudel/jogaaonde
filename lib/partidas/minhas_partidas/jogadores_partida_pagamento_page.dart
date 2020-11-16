import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_bloc.dart';
import 'package:jogaaonde/partidas/partidas_recentes/avaliacao_jogador.dart';
import 'package:jogaaonde/partidas/partidas_recentes/partidas_recentes.dart';
import 'package:jogaaonde/partidas/partidas_recentes/partidas_recentes_api.dart';
import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'package:jogaaonde/utils/widgets/custom_text_error.dart';
import 'package:jogaaonde/utils/widgets/custom_button.dart';
import 'package:mercado_pago_integration/core/failures.dart';
import 'package:mercado_pago_integration/mercado_pago_integration.dart';
import 'package:mercado_pago_integration/models/payment.dart';

class JodadoresPartidasPagamentoPage extends StatefulWidget {
  PartidasRecentes partidasRecentes;

  JodadoresPartidasPagamentoPage(this.partidasRecentes);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<JodadoresPartidasPagamentoPage> {
  String dropdownValue = "";
  List<Jogador> jogadores;
  final _bloc = JogadorBloc();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
  DateFormat hourFormat = DateFormat("HH:mm:ss");

  @override
  void initState() {
    _bloc.getJogadoresByPartida(widget.partidasRecentes);

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
                          "Listar Jogadores Partida",
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

            Text(
              'Quadra: ' + widget.partidasRecentes.descricao,
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _txtData(widget.partidasRecentes),
              style: GoogleFonts.lato(
                  color: Colors.white70,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Total: R\$" + widget.partidasRecentes.preco.toString(),
              style: GoogleFonts.lato(
                  color: Colors.white70,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            _listPartidasRecentess(),
            // Container(
            //   padding: EdgeInsets.only(left: 16, right: 16),
            //   child: CustomButton("CADASTRAR", _onClickConfirmarAvalicao),
            // )
            //GridDashboard()
          ],
        ),
      ),
    );
  }

  String _txtData(PartidasRecentes partRecentes) {
    var dataAbertura = DateTime.parse(partRecentes.data_abertura);
    var dataFechamento = DateTime.parse(partRecentes.data_fechamento);

    String dt_abertura = dateFormat.format(dataAbertura);
    String dt_fechamento = hourFormat.format(dataFechamento);

    return "$dt_abertura - $dt_fechamento";
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
          trailing: jogador.pago ? Icon(Icons.check) : Icon(Icons.monetization_on_rounded),
          onTap: () => _onClickPagar(jogador),
        ),
      );
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

  Future<void> _onRefresh() {
    return _bloc.getJogadoresByPartida(widget.partidasRecentes);
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

  _onClickPagar(Jogador jogador) async {
    double total = widget.partidasRecentes.preco / jogadores.length;

    final Map<String, Object> preference = {
      'items': [
        {
          'title': 'Test Product',
          'description': 'Description',
          'quantity': 1,
          'currency_id': 'BRL',
          'unit_price': total,
        }
      ],
      'payer': {'name': 'Buyer G.', 'email': 'test@gmail.com'},
    };

    final response = (await MercadoPagoIntegration.startCheckout(
      publicKey: "TEST-cb6fcf00-0dc2-4d60-abb7-c5b2f072a75f",
      preference: preference,
      accessToken:
          "TEST-373716422145450-111002-2c5edffd163aaf27791da1785da6ab91-216354271",
    ))
        .fold((Failure failure) {
      debugPrint('Failure => ${failure.message}');
    }, (Payment payment) {


      debugPrint('Payment => ${payment.paymentId}');
      setState(() {
        jogador.pago = true;
      });


    });


    if (response) {

    }
  }
}
