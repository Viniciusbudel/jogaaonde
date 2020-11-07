import 'dart:convert';

import 'package:jogaaonde/campeonato/campeonato.dart';
import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/prefs.dart';
import 'package:http/http.dart' as http;

class CampeonatoApi{

  static Future<List<Campeonato>> getCampeonatoByCidade(String cidade) async {
    try{
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/campeonato/buscar?cidade=$cidade';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);

      Map mapResponse = json.decode(response.body);
      List list = mapResponse["content"];

      if (response.statusCode == 200) {
        final quadras = list.map<Campeonato>((map) => Campeonato.fromJson(map)).toList();


        return quadras;
      }

      return null;
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return null;
    }
  }

  static Future<ApiResponse<Campeonato>> insertTimeCampeonato(
      String idTime, String idCampeonato) async {
    try {
      String token = await Prefs.getString("token");

      final params = {"campeonato_id": idCampeonato, "time_id": idTime};

      var url = 'https://jogaaonde.com.br/jogador/campeonato/add_jogador';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.post(url, body: params, headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.ok(mapResponse["message"]);

      }else{
        return ApiResponse.error(mapResponse["message"]);
      }

    } catch (error, exception) {
      print("erro no login $error > $exception");

      return null;
    }
  }
}