import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCardRow extends StatelessWidget {
  String title;
  String subTitle;

  CustomCardRow(this.title, this.subTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: Card(
        color: Colors.white70,
        elevation: 12.0,
        margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.lato(
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
              Text(
                subTitle ?? " - ",
                style: GoogleFonts.lato(
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
