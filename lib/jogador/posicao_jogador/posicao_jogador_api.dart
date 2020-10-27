import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/posicao_jogador/posicao_jogador.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/prefs.dart';

class PosicaoJogadorApi {

  static Future<List<PosicaoJogador>> getPosicaoJogador() async {
    try {
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/admin/posicao/buscar';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);
      Map mapResponse = json.decode(response.body);
      List list = mapResponse["content"];

      if (response.statusCode == 200) {
        final quadras = list
            .map<PosicaoJogador>((map) => PosicaoJogador.fromJson(map))
            .toList();

        return quadras;
      }

      return null;
    } catch (error, exception) {
      print("erro no login $error > $exception");
      return null;
    }
  }
}
