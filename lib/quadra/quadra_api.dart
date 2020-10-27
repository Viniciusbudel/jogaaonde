import 'dart:convert';

import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/prefs.dart';
import 'package:http/http.dart' as http;

class QuadraApi{
  static List<Quadra> getQuadras(){
    final quadras = List<Quadra>();

    // quadras.add(Quadra(descricao:  "Quadra coberta",empresasId: 1,urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));
    // quadras.add(Quadra(nome: "Quadra aberta",empresa: "Trieste Stadium",urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));
    // quadras.add(Quadra(nome: "Quadra coberta",empresa: "Bola murcha",urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));
    // quadras.add(Quadra(nome: "Quadra coberta",empresa: "Bola murcha",urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));
    // quadras.add(Quadra(nome: "Quadra coberta",empresa: "Bola murcha",urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));
    // quadras.add(Quadra(nome: "Quadra coberta",empresa: "Bola murcha",urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));
    // quadras.add(Quadra(nome: "Quadra coberta",empresa: "Bola murcha",urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));
    // quadras.add(Quadra(nome: "Quadra coberta",empresa: "Bola murcha",urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));
    // quadras.add(Quadra(nome: "Quadra coberta",empresa: "Bola murcha",urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));
    // quadras.add(Quadra(nome: "Quadra coberta",empresa: "Bola murcha",urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));
    // quadras.add(Quadra(nome: "Quadra coberta",empresa: "Bola murcha",urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));
    // quadras.add(Quadra(nome: "Quadra coberta",empresa: "Bola murcha",urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));
    // quadras.add(Quadra(nome: "Quadra coberta",empresa: "Bola murcha",urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));
    // quadras.add(Quadra(nome: "Quadra coberta",empresa: "Bola murcha",urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));
    // quadras.add(Quadra(nome: "Quadra coberta",empresa: "Bola murcha",urlFoto: "https://media.gazetadopovo.com.br/2019/11/20062402/c73bdbf0-f67b-11e9-b226-7b752c85f238-wp-660x372.jpg"));

    return quadras;
  }

  static Future<List<Quadra>> getQuadra() async {
    try{
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/quadra/buscar';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);



      Map mapResponse = json.decode(response.body);
      List list = mapResponse["content"];

      if (response.statusCode == 200) {
        final quadras = list.map<Quadra>((map) => Quadra.fromJson(map)).toList();


        return quadras;
      }

      return null;
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return null;
    }
  }
}