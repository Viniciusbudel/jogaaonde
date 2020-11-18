import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_bloc.dart';
import 'package:jogaaonde/pagamento/jogadores_pagamento.dart';
import 'package:jogaaonde/pagamento/jogadores_pagamento_api.dart';
import 'package:jogaaonde/pagamento/jogadores_pagamento_bloc.dart';
import 'package:jogaaonde/partidas/partidas_recentes/avaliacao_jogador.dart';
import 'package:jogaaonde/partidas/partidas_recentes/partidas_recentes.dart';
import 'package:jogaaonde/partidas/partidas_recentes/partidas_recentes_api.dart';
import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'package:jogaaonde/utils/widgets/custom_dialog.dart';
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
  List<JogadorPagamento> jogadores;
  final _bloc = JogadorPagamentoBloc();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
  DateFormat hourFormat = DateFormat("HH:mm:ss");

  @override
  void initState() {
    _bloc.getJogadorPagamentoByPartidaId(widget.partidasRecentes.id.toString());

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
            return TextError("Nenhum registro encontrado!");
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

  _listViewPartidasRecentess(List<JogadorPagamento> jogadores) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: jogadores.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(index);
      },
    );
  }

  makeListTile(JogadorPagamento jogadorPagamento) {
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
            jogadorPagamento.jogador.nome,
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
                    jogadorPagamento.status.descricao,
                    style: GoogleFonts.lato(fontSize: 16),
                  ),
                ],
              )),
          trailing: jogadorPagamento.status == "Pagamento pendente" ? Icon(
              Icons.check) : Icon(Icons.monetization_on_rounded),
          onTap: () => _onClickPagar(jogadorPagamento),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  makeCard(index) {
    JogadorPagamento jogador = jogadores[index];
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
    _bloc.getJogadorPagamentoByPartidaId(widget.partidasRecentes.id.toString());
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

  _onClickPagar(JogadorPagamento jogador) async {
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
      DialogUtils.showCustomDialog(context,
          title: "Erro no pagamento tente novamente!",
          okBtnText: "Ok",
          cancelBtnText: "",
          okBtnFunction: () => Navigator.pop(context) //Fazer algo
        //Fazer algo
      );

      debugPrint('Failure => ${failure.message}');
    }, (Payment payment)  async {

      // final response = await JogadorPagamentoApi.insertPagamento(
      //     jogador.status.id);
      // // debugPrint('Payment => ${payment.paymentId}');
      //
      // if (response.ok) {
      //   DialogUtils.showCustomDialog(context,
      //       title: "Sucesso você se juntou ao time",
      //       okBtnText: "Ok",
      //       cancelBtnText: "",
      //       okBtnFunction: () => Navigator.pop(context) //Fazer algo
      //     //Fazer algo
      //   );
      // }


    });


    response.whenComplete(() async {
      final response = await JogadorPagamentoApi.insertPagamento(
          jogador.id);
      // debugPrint('Payment => ${payment.paymentId}');

      if (response.ok) {
        DialogUtils.showCustomDialog(context,
            title: "Pagamento realizado com sucesso!",
            okBtnText: "Ok",
            cancelBtnText: "",
            okBtnFunction: () {
              Navigator.pop(context);
              _bloc.getJogadorPagamentoByPartidaId(widget.partidasRecentes.id.toString());
            } //Fazer algo
          //Fazer algo
        );
      }
    });
  }
}
