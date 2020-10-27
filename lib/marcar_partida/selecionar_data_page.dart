import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelecionarData extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<SelecionarData> {
  DateTime _dateTime;
  String dropdownValue = 'Dinheiro';

  final f = new DateFormat('dd/MM/yyyy');
  Horarios item1 = new Horarios(
    horario_inicial: "5:30",
    horario_final: "6:30",
    disponivel: true,
  );
  Horarios item2 = new Horarios(
    horario_inicial: "6:30",
    horario_final: "7:30",
    disponivel: true,
  );
  Horarios item3 = new Horarios(
    horario_inicial: "5:30",
    horario_final: "6:30",
    disponivel: true,
  );
  Horarios item4 = new Horarios(
    horario_inicial: "7:30",
    horario_final: "8:30",
    disponivel: true,
  );
  Horarios item5 = new Horarios(
    horario_inicial: "8:30",
    horario_final: "9:30",
    disponivel: true,
  );
  Horarios item6 = new Horarios(
    horario_inicial: "10:30",
    horario_final: "11:30",
    disponivel: false,
  );
  Horarios item7 = new Horarios(
    horario_inicial: "11:30",
    horario_final: "12:30",
    disponivel: true,
  );
  Horarios item8 = new Horarios(
    horario_inicial: "12:30",
    horario_final: "13:30",
    disponivel: true,
  );
  Horarios item9 = new Horarios(
    horario_inicial: "13:30",
    horario_final: "14:30",
    disponivel: true,
  );
  Horarios item10 = new Horarios(
    horario_inicial: "14:30",
    horario_final: "15:30",
    disponivel: true,
  );
  Horarios item11 = new Horarios(
    horario_inicial: "15:30",
    horario_final: "16:30",
    disponivel: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Container _body(BuildContext context) {
    List<Horarios> myList = [
      item1,
      item2,
      item3,
      item4,
      item5,
      item6,
      item7,
      item8,
      item9,
      item10,
      item11
    ];

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(children: <Widget>[
        _datePicker(context),
        _listView(myList),
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

  Flexible _listView(List<Horarios> myList) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.topCenter,
        child: ListView.builder(
            itemCount: myList.length,
            itemBuilder: (context, index) {
              Horarios horario = myList[index];

              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      horario.horario_inicial + " - " + horario.horario_final,
                      style: TextStyle(
                          fontSize: 20,
                          color:
                              horario.disponivel ? Colors.green : Colors.red),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 06),
        lastDate: DateTime(2021));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;

        _date.value = TextEditingValue(text: f.format(picked).toString());
      });
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
        onPressed: () => _configDialog(context),
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
                  decoration:
                      InputDecoration(hintText: "CVV"),
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

class Horarios {
  String horario_inicial;
  String horario_final;
  bool disponivel;

  Horarios({this.horario_inicial, this.horario_final, this.disponivel});
}
