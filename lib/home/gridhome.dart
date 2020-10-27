import 'package:flutter/material.dart';
import 'package:jogaaonde/empresa/lista_empresa_page.dart';
import 'package:jogaaonde/marcar_partida/selecionar_time_page.dart';
import 'package:jogaaonde/quadra/quadra_page.dart';
import 'package:jogaaonde/social/social_page.dart';


class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Minhas Reservas",
      subtitle: "Gerencie seus jogos!",
      event: "",
      img: "assets/images/soccer_128.png");

  Items item2 = new Items(
    title: "Nova Reserva",
    subtitle: "Faça sua reserva agora!",
    event: "",
    img: "assets/images/nova_reserva_128.png",
  );
  Items item3 = new Items(
    title: "Social",
    subtitle: "Adicione amigos para jogar!",
    event: "",
    img: "assets/images/social_128.png",
  );
  Items item4 = new Items(
    title: "Configurações",
    subtitle: "",
    event: "",
    img: "assets/images/config_128.png",
  );
  Items item5 = new Items(
    title: "Sair",
    subtitle: "Até logo!",
    event: "",
    img: "assets/images/quit_128.png",
  );

//  Items item6 = new Items(
//    title: "Settings",
//    subtitle: "",
//    event: "2 Items",
//    img: "assets/setting.png",
//  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5];
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
                      // do something
                        break;
                      case 1:
                        (push(context, SelecionarTimePage()));
                        break;
                      case 2:
                        (push(context, SocialPage()));
                        break;
                      case 3:
                        _configDialog(context);
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


_configDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return new AlertDialog(
          title: Text('Avalie sua ultima partida!'),

          actions: <Widget>[
            new FlatButton(
              child: new Text('Cancelar',style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('Avaliar',style: TextStyle(color: Colors.green),),
              onPressed: () {
                //_validaSenha(context, "Abre_Configuracao", ConfigPage(),"Senha inválida");
              },
            )
          ],
        );
      });
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
