import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class JodadoresPartidasPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<JodadoresPartidasPage> {
  String dropdownValue = "";
  IconData _icon = Icons.sentiment_neutral;

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
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Joga Aonde",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Partidas Recentes",
                        style: TextStyle(
                            color: Color(0xffa29aac),
                            fontSize: 14,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  IconButton(
                    alignment: Alignment.topCenter,
                    icon: Icon(Icons.list),
                    color: Colors.white70,
                    onPressed: () {},
                  )
                ],
              ),
            ),

            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return makeCard();
              },
            ),

            Container(
              padding: EdgeInsets.only(left: 16,right: 16),
              child: _buildCadastroBtn(),
            )
            //GridDashboard()
          ],
        ),
      ),

//      floatingActionButton: FloatingActionButton.extended(
//        icon: Icon(Icons.add),
//
//        label: Text("Cadastrar Time"),
//
//        backgroundColor: Colors.greenAccent[700],
//        onPressed: () { print('Clicked'); },),
    );
  }

  SafeArea makeListTile() {
    return SafeArea(
      child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text(
            "Cleiton Rasta",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              //Icon(Icons.assignment, color: Colors.white70),
              Text("LD", style: TextStyle(color: Colors.white))
            ],
          ),
          trailing: GestureDetector(
              onTap: () => _rateDialog(context), //PartidasRecentesPage
              child: Icon(_icon, color: Colors.white, size: 30.0))),
    );
  }

  makeCard() {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: GestureDetector(
        onTap: () => print('Clicado'),
        child: Container(
          //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          decoration: BoxDecoration(color: Color(0xFF05290C)),
          child: makeListTile(),
        ),
      ),
    );
  }

  _rateDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
              title: Text('Avalie Jogador'),
              content: RatingBar(
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
                    setState() => _icon = Icons.sentiment_very_satisfied;
                  }));
        });
  }

  Widget _buildCadastroBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => print('Login Button Pressed'),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'CONFIRMAR AVALIAÇÃO',
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
