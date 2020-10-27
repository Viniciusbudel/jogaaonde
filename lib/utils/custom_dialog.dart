import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(BuildContext context,
      {@required String title,
      String okBtnText = "Ok",
      String cancelBtnText = "Cancelar",
      @required Function okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Color(0xFF123c62),
            title: Text(
              title,
              style: GoogleFonts.lato(fontWeight: FontWeight.bold,color: Colors.white),
            ),
            //content: /* Here add your custom widget  */,
            actions: <Widget>[
              FlatButton(
                  child: Text(cancelBtnText,style: GoogleFonts.lato(color: Colors.deepOrange),),
                  onPressed: () => Navigator.pop(context)),
              FlatButton(
                child: Text(okBtnText,style: GoogleFonts.lato(color: Colors.deepOrange)),
                onPressed: okBtnFunction,
              ),
            ],
          );
        });
  }
}
