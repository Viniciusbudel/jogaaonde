import 'dart:convert';

import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/partidas_recentes/partidas_recentes.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/prefs.dart';
import 'package:http/http.dart' as http;

class PartidasRecentesApi{
  static Future<List<PartidasRecentes>> getPartidasRecentesByTime(String time) async {
    try{
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/partida/buscar?time_id=$time';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);

      Map mapResponse = json.decode(response.body);
      List list = mapResponse["content"];

      if (response.statusCode == 200) {
        final quadras = list.map<PartidasRecentes>((map) => PartidasRecentes.fromJson(map)).toList();

        return quadras;
      }

      return null;
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return null;
    }
  }
}