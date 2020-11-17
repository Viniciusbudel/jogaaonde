import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jogaaonde/home/gridhome.dart';
import 'dart:convert' as convert;

import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/time/time_page.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/prefs.dart';

class TimeApi {
  static Future<ApiResponse<Time>> insertTime(Time time) async {
    try {
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/time/cadastrar';
      String jsonUser = jsonEncode(time);
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}"
      };
      final response = await http.post(url, body: jsonUser, headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = Time.fromJson(mapResponse);

        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse["message"]);
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return ApiResponse.error(
          "Não foi possivel realizar o login erro inesperado");
    }
  }

  static Future<ApiResponse<Time>> updateTime(Time time) async {
    try {
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/time/alterar';
      String jsonUser = jsonEncode(time);
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}"
      };
      final response = await http.put(url, body: jsonUser, headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = Time.fromJson(mapResponse);

        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse["message"]);
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return ApiResponse.error(
          "Não foi possivel alterar o time!");
    }
  }

  static Future<List<Time>> getTime() async {
    try {
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/time/me';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);

      Map mapResponse = json.decode(response.body);
      List list = mapResponse["content"];

      if (response.statusCode == 200) {
        final quadras = list.map<Time>((map) => Time.fromJson(map)).toList();

        return quadras;
      }

      return throw Exception("Erro ao buscar");
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return throw Exception("Erro ao buscar");
    }
  }

  static Future<List<Time>> getTimeByCidade(String cidade) async {
    try {
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/time/buscar?cidade=$cidade&aceita_time=true';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);

      Map mapResponse = json.decode(response.body);
      List list = mapResponse["content"];

      if (response.statusCode == 200) {
        final quadras = list.map<Time>((map) => Time.fromJson(map)).toList();

        return quadras;
      }

      return throw Exception("Erro ao buscar");
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return throw Exception("Erro ao buscar");
    }
  }

  static Future<ApiResponse<Time>> addJogadorTime(
      String idJogador, String idTime) async {
    try {
      String token = await Prefs.getString("token");

      final params = {"jogador_id": idJogador, "time_id": idTime};

      var url = 'https://jogaaonde.com.br/jogador/time/add_jogador';


      final body = jsonEncode(params);
      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.post(url, body: body, headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.ok(null);

      }else{
        return ApiResponse.error(mapResponse["message"]);
      }

    } catch (error, exception) {
      print("erro no login $error > $exception");

      return throw Exception("Erro ao buscar");
    }
  }
}
