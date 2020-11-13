import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogaaonde/utils/constants.dart';

class CustomSearchRow extends StatelessWidget {
  final void Function() asyncFunc;

  String hint;
  TextEditingController controller;

  CustomSearchRow(this.hint,this.controller,this.asyncFunc);



  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        decoration: kBoxDecorationStyle,
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: TextField(
                controller: controller,
                obscureText: false,
                style: GoogleFonts.lato(
                  letterSpacing: 1.0,
                  fontSize: 14.0,
                  //fontWeight: FontWeight.w300,
                  //color: Color(0xFF123c62),
                  color: Colors.red[700],
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.red[700],
                  ),
                  hintText: hint,
                  hintStyle: GoogleFonts.lato(
                    letterSpacing: 1.0,
                    fontSize: 14.0,
                    //fontWeight: FontWeight.w300,
                    //color: Color(0xFF123c62),
                    color: Colors.red[700],
                  ),
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
                      side: BorderSide(color: Colors.red[400])),
                  color: Colors.red[700],
                  onPressed: asyncFunc,
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
}
