import 'package:flutter/material.dart';
import 'package:jogaaonde/partidas_recentes/jogadores_partida_page.dart';
import 'package:jogaaonde/utils/nav.dart';

class PartidasRecentesPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PartidasRecentesPage> {
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
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return makeCard();
              },
            ),

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

  SafeArea makeListTile(){
  return SafeArea(
    child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.assistant_photo, color: Colors.white),
        ),
        title: Text(
          "Triste Stadium - Quadra Coberta",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            //Icon(Icons.assignment, color: Colors.white70),
            Text("18:30 - 19:30", style: TextStyle(color: Colors.white))
          ],
        ),
        trailing: GestureDetector(
            onTap: () => push(this.context, JodadoresPartidasPage()), //PartidasRecentesPage
            child: Icon(Icons.star, color: Colors.white, size: 30.0))),
  );}

   makeCard(){
    return  Card(
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
}
