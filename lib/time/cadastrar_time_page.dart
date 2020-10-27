import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/time/time_bloc.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'package:jogaaonde/utils/custom_dialog.dart';
import 'package:jogaaonde/utils/nav.dart';

class NovoTime extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NovoTime> {
  String _dropdownValue = "";
  final _formKey = GlobalKey<FormState>();


  List<String> ufs = [
    " ",
    "AC",
    "AL",
    "AP",
    "AM",
    "BA",
    "CE",
    "ES",
    "GO",
    "MA",
    "MT",
    "MS",
    "MG",
    "PA",
    "PB",
    "PR",
    "PE",
    "PI",
    "RJ",
    "RN",
    "RS",
    "RO",
    "RR",
    "SC",
    "SP",
    "SE",
    "TO",
    "DF"
  ];

  bool showProgress = false;

  final _timeBloc = TimeBloc();

  final _tNome = TextEditingController();
  final _tDescricao = TextEditingController();
  final _tEscudo = TextEditingController();
  final _tCidade = TextEditingController();
  final _tUf = TextEditingController();

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF04220A),
      body: SingleChildScrollView(
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
                          "Novo Time",
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
            Container(
              //height: double.infinity,

              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  _buildNomeTF(),
                  SizedBox(height: 20),
                  _buildDescricao(),
                  SizedBox(height: 20),
                  _dropDown(),
                  SizedBox(height: 20),
                  _buildCidadeTF(),
                  SizedBox(height: 20),
                  _buildCadastroBtn(),
                ],
              ),
            )
            //GridDashboard()
          ],
        ),
      ),
    );
  }

  Widget _buildNomeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nome do Time',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyleGreen,
          height: 60.0,
          child: TextField(
            controller: _tNome,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.mode_edit,
                color: Colors.white,
              ),
              hintText: 'De um nome para seu time!',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCidadeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Cidade',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyleGreen,
          height: 60.0,
          child: TextField(
            controller: _tCidade,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.location_city,
                color: Colors.white,
              ),
              hintText: 'Digite cidade do seu time!',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescricao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Descrição',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyleGreen,
          height: 60.0,
          child: TextField(
            controller: _tDescricao,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.list,
                color: Colors.white,
              ),
              hintText: 'De uma descrição para seu time!',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
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
          'CADASTRAR',
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

  onClickCadastrarTime() async {
    //if (_formKey.currentState.validate()) {
    setState(() {
      showProgress = true;
    });

    var time = Time(
      nome: _tNome.text,
      cidade: _tCidade.text,
      uf: _dropdownValue,
      descricao: _tDescricao.text,
      escudo: "teste",
      aceitaIntegrantes: true,
    );

    final response = await _timeBloc.inserirTime(time);

    if (response.ok) {
      DialogUtils.showCustomDialog(context,
          title: "Time Cadastrado com Sucesso!",
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

  // }

  Widget _dropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "UF",
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyleGreen,
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                    )),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  //alignment: Alignment.center,
                  child: DropdownButtonHideUnderline(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.green,
                      ),
                      child: DropdownButton<String>(
                        value: _dropdownValue,
                        style: GoogleFonts.lato(color: Colors.white54),
                        onChanged: (String newValue) {
                          _dropdownValue = newValue;
                          setState(() {
                            _dropdownValue;
                          });
                        },
                        items:
                            ufs.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                        hint: Text(
                          'Selecione a UF',
                          style: kFieldTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
