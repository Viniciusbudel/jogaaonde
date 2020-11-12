import 'package:flutter/material.dart';
import 'package:jogaaonde/campeonato/campeonato_page.dart';
import 'package:jogaaonde/jogador/cadastro_jogador_page.dart';
import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_bloc.dart';
import 'package:jogaaonde/time/cadastrar_time_page.dart';
import 'package:jogaaonde/time/lista_times_page.dart';
import 'package:jogaaonde/time/lista_times_proximos_page.dart';

class GridSocial extends StatelessWidget {
  Items item1 = new Items(
      title: "Meus Times",
      subtitle: "Gerencie seus times!",
      event: "",
      img: "assets/images/gerenciar_times_128.png");

  Items item2 = new Items(
    title: "Novo Time",
    subtitle: "Crie um novo time!!",
    event: "",
    img: "assets/images/novo_time_128.png",
  );

  Items item3 = new Items(
    title: "Partidas Recentes",
    subtitle: "",
    event: "",
    img: "assets/images/partidas_recentes_128.png",
  );
  Items item4 = new Items(
    title: "Campeonatos",
    subtitle: "Jogue campeonatos regionais!",
    event: "",
    img: "assets/images/campeonato_128.png",
  );
  Items item5 = new Items(
    title: "Procurar Partida",
    subtitle: "Procure partidas próximas!",
    event: "",
    img: "assets/images/procurar_partida.png",
  );
  Items item6 = new Items(
    title: "Encontrar Time",
    subtitle: "Junte-se a times!",
    event: "",
    img: "assets/images/buscar_time.png",
  );

  // Items item5 = new Items(
  //   title: "Sair",
  //   subtitle: "Até logo!",
  //   event: "",
  //   img: "assets/images/quit_128.png",
  // );

//  Items item6 = new Items(
//    title: "Settings",
//    subtitle: "",
//    event: "2 Items",
//    img: "assets/setting.png",
//  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xFF3D6344;
    return Flexible(
        child: GridView.builder(
            itemCount: myList.length,
            //childAspectRatio: 1.0,
            padding: EdgeInsets.only(left: 16, right: 16, top: 5),

//          crossAxisCount: 2,
//          crossAxisSpacing: 18,
//          mainAxisSpacing: 18,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 18, mainAxisSpacing: 18),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Color(0xFF05290C),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
//                    blurRadius: 3.0,
//                    offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    switch (index) {
                      case 0:
                        (push(context, ListarTimePage("home")));
                        break;
                      case 1:
                        (push(context, NovoTime()));
                        break;
                      case 2:
                        (push(context, ListarTimePage("partidasRecentes")));
                        break;
                      case 3:
                        (push(context, CampeonatoPage()));
                        break;
                      case 4:
                        (push(context, ListarTimePage("procurarPartida")));
                        break;
                      case 5:
                        (push(context, ListarTimesProximosPage()));
                        break;
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        myList[index].img,
                        width: 42,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        myList[index].title,
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: 'OpenSans',
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        myList[index].subtitle,
                        style: TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}

Future push(BuildContext context, Widget page) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) {
    return page;
  }));
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;

  Items({this.title, this.subtitle, this.event, this.img});
}
