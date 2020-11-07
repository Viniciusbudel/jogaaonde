import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/social/gridsocial.dart';

class SocialPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF04220A),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
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
                  onPressed: () =>
                      _onBackPressed()
                  ,
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
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Social ",
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
            height: 40,
          ),
          GridSocial()
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
      push(context, HomePage()); //Fazer algo
  }
}
