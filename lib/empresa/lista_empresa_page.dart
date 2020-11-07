import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/empresa/empresa_bloc.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/marcar_partida/selecionar_data_page.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/quadra/quadra_bloc.dart';
import 'package:jogaaonde/quadra/quadra_page.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'package:jogaaonde/utils/text_error.dart';

class ListaEmpresaPage extends StatefulWidget {
  String idTime;

  ListaEmpresaPage(this.idTime);

  @override
  _ListaEmpresaPageState createState() => _ListaEmpresaPageState();
}

class _ListaEmpresaPageState extends State<ListaEmpresaPage> {
  final _bloc = EmpresaBloc();
  List<Empresa> quadras;
  final _tNome = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _bloc.getEmpresaByCidade("Curitiba");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor: Color(0xFF05290C),
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
                              "Listar Empresa",
                              style: GoogleFonts.lato(
                                  color: Color(0xffa29aac),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      //                    IconButton(
                      //                      alignment: Alignment.topCenter,
                      //                      icon: Icon(Icons.list),
                      //                      color: Colors.white70,
                      //                      onPressed: () {},
                      //                    )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                _rowBuscar(),
                _listEmpresas(),

                //GridDashboard()
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  _listEmpresas() {
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
          quadras = snapshot.data;
          return RefreshIndicator(
              onRefresh: _onRefresh, child: _listViewEmpresas(quadras));
          //child: EmpresaListView(quadras, widget.origem));
        });
  }

  _listViewEmpresas(List<Empresa> quadras) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: quadras.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(index, context);
      },
    );
  }

  //     return Container(
  //       padding: EdgeInsets.all(8),
  //       child: GestureDetector(
  //         onTap: () {
  //           push(context, SelecionarData());
  //         },
  //         child: Card(
  //           color: Color(0xFF05290C),
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(1),
  //               side: BorderSide(color: Colors.white, width: 0.1)),
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: <Widget>[
  //               Image.network(
  //                 quadra.imagens[0],
  //                 width: 150,
  //                 height: 100,
  //                 fit: BoxFit.fill,
  //               ),
  //               Container(
  //                 padding: EdgeInsets.only(left: 16),
  //                 child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: <Widget>[
  //                       Text(
  //                         quadra.imagens[0],
  //                         style: TextStyle(
  //                           fontSize: 22,
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.bold,
  //                           fontFamily: 'OpenSans',
  //                         ),
  //                       ),
  //                       Text(
  //                         quadra.descricao,
  //                         style:
  //                             TextStyle(fontSize: 15, color: Colors.white70),
  //                       ),
  //                       Container(
  //                         padding: EdgeInsets.only(top: 30),
  //                         child: Text(
  //                           "5km",
  //                           style: TextStyle(
  //                               fontSize: 15, color: Colors.white70),
  //                         ),
  //                       ),
  //                     ]),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //
  //     return ListTile(
  //       leading: Image.network(quadra.imagens[0]),
  //       title: Text(
  //         quadra.descricao,
  //         style: TextStyle(fontSize: 22),
  //       ),
  //     );
  //   },
  // );

  makeListTile(index, context) {
    Empresa e = quadras[index];
    return GestureDetector(
      onTap: () => push(context, ListarQuadraPage(e, widget.idTime)),
      child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.work, color: Colors.white),
          ),
          title: Text(
            e.nomeFantasia,
            //c.ordemServico,
            style: GoogleFonts.lato(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: GoogleFonts.lato(color: Colors.white)),

          // subtitle: Row(
          //   children: <Widget>[
          //     //Icon(Icons.assignment, color: Colors.white70),
          //     _textData(c),
          //   ],
          // ),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0)),
    );
  }

  Padding _rowBuscar() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: kBoxDecorationStyle,
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: TextField(
                controller: _tNome,
                obscureText: false,
                style: kFieldTextStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.orange[700],
                  ),
                  hintText: "Buscar por nome",
                  hintStyle: kHintTextStyle,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.orange[400])),
                  color: Colors.orange[700],
                  onPressed: () => "",
                  child: Text(
                    "Buscar",
                    style: GoogleFonts.lato(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Card makeCard(int index, context) {
    Empresa c = quadras[index];

    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.green),
        child: makeListTile(index, context),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _bloc.dispose();
  }

  Future<void> _onRefresh() {
    return _bloc.getEmpresaByCidade("Curitiba");
  }

  Future<bool> _onBackPressed() async {
    push(context, HomePage());
  }
}
