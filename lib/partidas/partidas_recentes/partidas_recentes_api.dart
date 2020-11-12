import 'dart:convert';
import 'package:jogaaonde/partidas/partida.dart';
import 'package:jogaaonde/partidas/partidas_recentes/avaliacao_jogador.dart';
import 'package:jogaaonde/partidas/partidas_recentes/partidas_recentes.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/prefs.dart';
import 'package:http/http.dart' as http;

class PartidasRecentesApi {
  static Future<List<PartidasRecentes>> getPartidasRecentesByTime(
      String time) async {
    try {
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/partida/buscar?time_id=$time';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);

      Map mapResponse = json.decode(response.body);
      List list = mapResponse["content"];

      if (response.statusCode == 200) {
        final quadras = list
            .map<PartidasRecentes>((map) => PartidasRecentes.fromJson(map))
            .toList();

        return quadras;
      }

      return null;
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return null;
    }
  }

  static Future<List<PartidasRecentes>> getPartidasByCidade(
      String cidade) async {
    try {
      String token = await Prefs.getString("token");

      var url =
          'https://jogaaonde.com.br/jogador/partida/buscar?cidade=$cidade';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);

      Map mapResponse = json.decode(response.body);
      List list = mapResponse["content"];

      if (response.statusCode == 200) {
        final quadras = list
            .map<PartidasRecentes>((map) => PartidasRecentes.fromJson(map))
            .toList();

        return quadras;
      }

      return null;
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return null;
    }
  }

  static Future<ApiResponse> updatePartida(Partida partida) async {
    try {
      String token = await Prefs.getString("token");
      String jsonPartida = jsonEncode(partida);

      var url =
          'https://jogaaonde.com.br/jogador/partida/alterar';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.put(url, headers: headers,body: jsonPartida);
      Map mapResponse = json.decode(response.body);


      if (response.statusCode == 200) {
        return ApiResponse.ok(null);
      }

      return ApiResponse.error(mapResponse["message"]);
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return ApiResponse.error("Erro desconhecido");
    }
  }

  static Future<ApiResponse<AvaliacaoJogador>> insertAvaliacaoJogador(
      List<AvaliacaoJogador> avaliacaoJogador, String idPartida) async {
    try {
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/partida/avaliar/jogador';

      int id = int.parse(idPartida);
      String jsonUser = jsonEncode(avaliacaoJogador);
      String jsonAvaliacao = '{"partida_id": $id,"avaliacoes" : $jsonUser}';

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}"
      };

      final response =
          await http.post(url, body: jsonAvaliacao, headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = AvaliacaoJogador.fromJson(mapResponse);

        return ApiResponse.ok(user);
      }

      //amoobudel
      return ApiResponse.error(mapResponse["message"]);
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return ApiResponse.error(
          "Não foi possivel realizar o login erro inesperado");
    }
  }
}
