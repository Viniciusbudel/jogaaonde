import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jogaaonde/marcar_partida/cadastrar_partida.dart';
import 'package:jogaaonde/marcar_partida/cadastrar_partida_api.dart';
import 'package:jogaaonde/marcar_partida/horario_partida/horario_partida.dart';
import 'package:jogaaonde/marcar_partida/horario_partida/horario_partida_bloc.dart';
import 'package:jogaaonde/utils/custom_dialog.dart';
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
  DateTime _dateTime;

  MaterialColor _color = Colors.grey;
  String dropdownValue = 'Dinheiro';

  final _bloc = HorarioPartidaBloc();
  List<HorarioPartida> horarios;

  @override
  void initState() {
    // TODO: implement initState
    //_bloc.listarJogadors();
    super.initState();
  }

  final f = new DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(children: <Widget>[
        _datePicker(context),
        _listHorarios(),
        _dropDown(),
        _buildCadastroBtn()
      ]),
    );
  }

  Container _datePicker(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TextFormField(
            controller: _date,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              hintText: 'Selecione a data da reserva',
              prefixIcon: Icon(
                Icons.dialpad,
                //color: _icon,
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
            return Center(
              // child: CircularProgressIndicator(),
            );
          }
          horarios = snapshot.data;
          return RefreshIndicator(
              onRefresh: _onRefresh, child: _list(horarios, widget.idTime));
        });
  }

  _list(List<HorarioPartida> horarios, String idTime) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: horarios.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(index, context);
      },
    );
  }

  makeListTile(index, context) {
    HorarioPartida c = horarios[index];
    return GestureDetector(
      onTap: () => _mudaCor(),
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.access_alarm, color: Colors.white),
          ),
          title: _textData(c),
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
      horaAbertura +"  -  "+horaFechamento,
          style: GoogleFonts.lato(
              color: Colors.white, fontWeight: FontWeight.bold),
        );
  }

  Card makeCard(int index, context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: _color),
        child: makeListTile(index, context),
      ),
    );
  }


  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2021));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      String data = selectedDate.toString();
      data = data.replaceAll(" ", "T");

      _bloc.getHorarioPartida(data);

      setState(() {
        ///jogador/horario_quadra/buscar?quadra_id=1&data_abertura=2020-11-28T00:00:00&data_fechamento=2020-11-29T00:00:00

        _date.value = TextEditingValue(text: f.format(picked).toString());
      });
    }
  }

  Widget _dropDown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("Selecione um tipo de pagamento"),
        DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.green),
          underline: Container(
            height: 2,
            color: Colors.green[700],
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>[
            'Dinheiro',
            'Crédito',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _buildCadastroBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
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

  _configDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: Text('Dados do cartão'),
            content: new SingleChildScrollView(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    obscureText: true,
                    //controller: _textFieldSenhaController,
                    decoration: InputDecoration(
                        hintText: "Digite o nome do proprietario do cartão"),
                    //keyboardType: TextInputType.text,
                  ),
                  TextField(
                    obscureText: true,
                    //controller: _textFieldSenhaController,
                    decoration: InputDecoration(hintText: "Numero do cartão"),
                    //keyboardType: TextInputType.text,
                  ),
                  TextField(
                    obscureText: true,
                    //controller: _textFieldSenhaController,
                    decoration: InputDecoration(hintText: "Data de vencimento"),
                    //keyboardType: TextInputType.text,
                  ),
                  TextField(
                    obscureText: true,
                    //controller: _textFieldSenhaController,
                    decoration: InputDecoration(hintText: "CVV"),
                    //keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('Salvar'),
                onPressed: () {
                  //_validaSenha(context, "Abre_Configuracao", ConfigPage(),"Senha inválida");
                },
              )
            ],
          );
        });
  }

  Future<void> _onRefresh() {
    //return _bloc.listarJogadors();
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
      horarioQuadraId: 2,
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

  _mudaCor() {
    setState(() {
      _color = Colors.green;
    });
  }
}

class Horarios {
  String horario_inicial;
  String horario_final;
  bool disponivel;

  Horarios({this.horario_inicial, this.horario_final, this.disponivel});
}
