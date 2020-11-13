import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextError extends StatelessWidget {
  String textError;

  TextError(this.textError);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      textError,
      style: GoogleFonts.lato(
        color: Colors.red,
        fontSize: 22,
      ),
    ));
  }
}
