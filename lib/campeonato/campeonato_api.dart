import 'dart:convert';

import 'package:jogaaonde/campeonato/campeonato.dart';
import 'package:jogaaonde/campeonato/campeonato_chaves.dart';
import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/prefs.dart';
import 'package:http/http.dart' as http;

class CampeonatoApi {
  static Future<List<Campeonato>> getCampeonatoByCidade(String cidade) async {
    try {
      String token = await Prefs.getString("token");

      var url =
          'https://jogaaonde.com.br/jogador/campeonato/buscar?cidade=$cidade';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);

      Map mapResponse = json.decode(response.body);
      List list = mapResponse["content"];

      if (response.statusCode == 200) {
        final quadras =
            list.map<Campeonato>((map) => Campeonato.fromJson(map)).toList();

        return quadras;
      }

      return throw Exception("Erro ao buscar");
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return throw Exception("Erro ao buscar");
    }
  }

  static Future<List<Campeonato>> getCampeonatoByTimeId(String timeId) async {
    try {
      String token = await Prefs.getString("token");

      var url =
          'https://jogaaonde.com.br/jogador/campeonato/buscar?time_id=$timeId';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);

      Map mapResponse = json.decode(response.body);
      List list = mapResponse["content"];

      if (response.statusCode == 200) {
        final camp =
            list.map<Campeonato>((map) => Campeonato.fromJson(map)).toList();

        return camp;
      }

      return throw Exception("Erro ao buscar");
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return throw Exception("Erro ao buscar");
    }
  }
  static Future<CampeonatoChaves> getCampeonatoChavesById(String timeId) async {
    try {
      String token = await Prefs.getString("token");

      var url =
          'https://jogaaonde.com.br/jogador/partida_campeonato/buscar?campeonato_id=$timeId';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final camp =  CampeonatoChaves.fromJson(mapResponse["content"]);

        return camp;
      }

      return throw Exception("Erro ao buscar");
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return throw Exception("Erro ao buscar");
    }
  }

  static Future<ApiResponse<Campeonato>> insertTimeCampeonato(
      String idTime, String idCampeonato) async {
    try {
      String token = await Prefs.getString("token");

      int idCamp = int.parse(idCampeonato);
      int idTim = int.parse(idTime);

      final params = {"campeonato_id": idCamp, "time_id": idTim};

      var url = 'https://jogaaonde.com.br/jogador/campeonato/add_time';
      String body = json.encode(params);

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.post(url, body: body, headers: headers);
      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.ok(mapResponse["message"]);
      } else {
        return ApiResponse.error(mapResponse["message"]);
      }
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return null;
    }
  }
}
