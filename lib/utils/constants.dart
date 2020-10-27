import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kHintTextStyle = GoogleFonts.lato(
  letterSpacing: 1.0,
  fontSize: 14.0,
  //fontWeight: FontWeight.w300,
  //color: Color(0xFF123c62),
  color: Colors.green[400],
);

final kFieldTextStyle = GoogleFonts.lato(
  letterSpacing: 1.0,
  fontSize: 14.0,
  //fontWeight: FontWeight.w300,
  //color: Color(0xFF123c62),
  color: Colors.green[400],
);

final kLabelStyle = GoogleFonts.lato(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(15.0),
  boxShadow: [
    BoxShadow(
      color: Colors.white70,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kBoxDecorationRequiredStyle = BoxDecoration(
  color: Colors.yellow[50],
  borderRadius: BorderRadius.circular(15.0),
  boxShadow: [
    BoxShadow(
      color: Colors.white70,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);


final kBoxDecorationStyleGreen = BoxDecoration(
  color: Color(0xFF05290C),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.greenAccent,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);