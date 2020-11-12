import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/partidas/marcar_partida/cadastrar_partida.dart';
import 'package:jogaaonde/partidas/marcar_partida/cadastrar_partida_api.dart';
import 'package:jogaaonde/partidas/marcar_partida/horario_partida/horario_partida.dart';
import 'package:jogaaonde/partidas/marcar_partida/horario_partida/horario_partida_bloc.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'package:jogaaonde/utils/custom_dialog.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'package:jogaaonde/utils/text_error.dart';

class SelecionarData extends StatefulWidget {
  String idTime;
  String idQuadra;

  SelecionarData(this.idTime, this.idQuadra);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<SelecionarData> {
  bool showProgress = false;
  TextEditingController _date = new TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime dateNow = DateTime.now();
  String data;
  MaterialColor _color = Colors.grey;
  String dropdownValue = 'Dinheiro';

  final _bloc = HorarioPartidaBloc();
  List<HorarioPartida> horarios;
  HorarioPartida horarioSelecionado;

  @override
  void initState() {
    // TODO: implement initState
    //_bloc.listarJogadors();
    super.initState();
  }

  final f = new DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Color(0xFF05290C),
        body: Column(
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
                          "Listar Quadra",
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
            //SizedBox(height: 10),

            _datePicker(context),
            _listHorarios(),

            //_buildCadastroBtn()

            //GridDashboard()
          ],
        ),
        bottomSheet: _buildCadastroBtn(),
      ),
    );
  }

  Container _datePicker(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, right: 16, left: 16),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TextFormField(
            style: kFieldTextStyle,
            controller: _date,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              hintText: 'Selecione a data da reserva',
              hintStyle: kHintTextStyle,
              prefixIcon: Icon(
                Icons.dialpad,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _listHorarios() {
    return StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return TextError("Não foi possivel buscar os dados!");
          }
          if (!snapshot.hasData) {
            // return Center(
            //   child: CircularProgressIndicator(),
            // );
            return Container();
          }
          horarios = snapshot.data;
          return RefreshIndicator(
              onRefresh: _onRefresh, child: _list(horarios, widget.idTime));
        });
  }

  _list(List<HorarioPartida> horarios, String idTime) {
    return Container(
      height: 600,
      child: ListView.builder(
        //physics: NeverScrollableScrollPhysics(),
        //shrinkWrap: true,
        itemCount: horarios.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(index, context);
        },
      ),
    );
  }

  makeListTile(HorarioPartida horarioPartida) {
    return GestureDetector(
      onTap: () => _mudaCor(horarioPartida),
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.access_alarm, color: Colors.white),
          ),
          title: _textData(horarioPartida),
          // subtitle: Text("Intermediate", style: GoogleFonts.lato(color: Colors.white)),

          // subtitle: Row(
          //   children: <Widget>[
          //     //Icon(Icons.assignment, color: Colors.white70),
          //     Text(c.email, style: GoogleFonts.lato(color: Colors.white))
          //   ],
          // ),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0)),
    );
  }

  Text _textData(HorarioPartida c) {
    var dataAbertura = DateTime.parse(c.dataAbertura);
    var dataFechamento = DateTime.parse(c.dataFechamento);
    DateFormat dateFormat = DateFormat("HH:mm:ss");

    String horaAbertura = dateFormat.format(dataAbertura);
    String horaFechamento = dateFormat.format(dataFechamento);

    return Text(
      horaAbertura + "  -  " + horaFechamento,
      style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Card makeCard(int index, context) {
    HorarioPartida horarioPartida = horarios[index];

    return Card(

      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: horarioPartida.clicado ? Colors.green : Colors.grey),
        child: makeListTile(horarioPartida),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    try {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: dateNow,
          firstDate: dateNow,
          lastDate: DateTime(2021));
      if (picked != null) {
        selectedDate = picked;
        data = selectedDate.toString();
        data = data.replaceAll(" ", "T");

        _bloc.getHorarioPartida(data, widget.idQuadra);

        setState(() {
          ///jogador/horario_quadra/buscar?quadra_id=1&data_abertura=2020-11-28T00:00:00&data_fechamento=2020-11-29T00:00:00

          _date.value = TextEditingValue(text: f.format(picked).toString());
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _buildCadastroBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 20),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => onClickCadastrarTime(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'CONFIRMAR',
          style: TextStyle(
            color: Colors.greenAccent[400],
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }


  Future<void> _onRefresh() {
    return _bloc.getHorarioPartida(data, widget.idQuadra);;
  }

  onClickCadastrarTime() async {
    //if (_formKey.currentState.validate()) {
    setState(() {
      showProgress = true;
    });

    var time = CadastrarPartida(
      aceitaTime: true,
      anfitriaoTimeId: int.parse(widget.idTime),
      convidadoTimeId: null,
      descricao: "Teste",
      horarioQuadraId: horarioSelecionado.id,
    );

    final response = await CadastrarPartidaApi.cadastrarPartida(time);

    if (response.ok) {
      DialogUtils.showCustomDialog(context,
          title: "Partida criada com Sucesso!",
          okBtnText: "Ok",
          cancelBtnText: "",
          okBtnFunction: () => Navigator.pop(context)
          //push(context, TimesPage("home")) //Fazer algo
          //Fazer algo
          );
    } else {
      DialogUtils.showCustomDialog(context,
          title: response.msg,
          okBtnText: "Ok",
          cancelBtnText: "",
          okBtnFunction: () => Navigator.pop(context)
          //push(context, TimesPage("home")) //Fazer algo
          //Fazer algo
          );

      setState(() {
        showProgress = false;
      });
    }
  }

  _mudaCor(HorarioPartida horarioPartida) {
    horarios.forEach((element) {
      element.clicado = false;
    });

    horarioSelecionado = horarioPartida;

    setState(() {
      horarioPartida.clicado = true;
    });
  }

  Future<bool> _onBackPressed() {}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _bloc.dispose();
  }
}
