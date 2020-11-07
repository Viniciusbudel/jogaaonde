import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/marcar_partida/selecionar_data_page.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/quadra/quadra_bloc.dart';
import 'package:jogaaonde/utils/constants.dart';
import 'package:jogaaonde/utils/nav.dart';
import 'package:jogaaonde/utils/text_error.dart';

class ListarQuadraPage extends StatefulWidget {
  Empresa empresa;
  String idTime;

  ListarQuadraPage(this.empresa,this.idTime);

  @override
  _ListarQuadraPageState createState() => _ListarQuadraPageState();
}

class _ListarQuadraPageState extends State<ListarQuadraPage> {
  final _bloc = QuadraBloc();
  List<Quadra> quadras;
  final _tNome = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _bloc.getQuadraByEmpresa(widget.empresa.id.toString());
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
                              "Listar Quadra",
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
                _listQuadras(),

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

  _listQuadras() {
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
              onRefresh: _onRefresh, child: _listViewQuadras(quadras));
          //child: QuadraListView(quadras, widget.origem));
        });
  }

  _listViewQuadras(List<Quadra> quadras) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: quadras.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(index, context);
      },
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

  makeCard(int index, context) {
    Quadra quadra = quadras[index];
    return GestureDetector(
      onTap: () => push(context, SelecionarData(widget.idTime,quadra.id.toString())),

      child: Card(
        color: Color(0xFF05290C),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1),
            side: BorderSide(color: Colors.white, width: 0.1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            quadra.imagem != null ?
            Image.network(
              quadra.imagem,
              width: 150,
              height: 100,
              fit: BoxFit.fill,
            ) : Container(),
            Container(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      quadra.descricao,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        "5km",
                        style: TextStyle(fontSize: 15, color: Colors.white70),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
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
    return _bloc.getQuadraByEmpresa(widget.empresa.id.toString());
  }

  Future<bool> _onBackPressed() async {
    push(context, HomePage());
  }
}
