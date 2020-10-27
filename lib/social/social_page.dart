import 'package:flutter/material.dart';
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
                      "Social",
                      style:  TextStyle(
                              color: Color(0xffa29aac),
                              fontSize: 14,
                          fontFamily: 'OpenSans',

                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
//                IconButton(
//                  alignment: Alignment.topCenter,
//                  icon: Icon(Icons.list),
//                  color: Colors.white70,
//                  onPressed: () {},
//                )
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
}
