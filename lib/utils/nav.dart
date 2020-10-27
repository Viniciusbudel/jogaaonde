
import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page) {
  return Navigator.push(context, MaterialPageRoute(builder: (context){
    return page;
  }));
}

Future pushReplacement(BuildContext context, Widget page) {
  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
    return page;
  }));
}

//Alterado em: 25/05/2020 Vinícius Budel corrigir erro:
// A value of type 'void' can't be returned from function 'pop' because it has a return type of 'bool'.
//https://stackoverflow.com/questions/51478405/how-to-return-future-or-any-other-types-from-a-function-in-dart
Future<bool> pop<T extends Object>(context, [ T result ]) {
  Navigator.pop(context, result);
  return Future.value(false);
}

Future pushAndRemove(BuildContext context, Widget page){
  return Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context){
  return page;
  }),ModalRoute.withName('/'),);

}