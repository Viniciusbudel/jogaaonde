import 'dart:convert';

import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/marcar_partida/cadastrar_partida.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/prefs.dart';
import 'package:http/http.dart' as http;

class CadastrarPartidaApi{

  static Future<ApiResponse<CadastrarPartida>> cadastrarPartida(CadastrarPartida partida) async {
    try {
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/partida/cadastrar';
      String jsonUser = jsonEncode(partida);

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}"
      };
      final response = await http.post(url, body: jsonUser, headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        //final user = Time.fromJson(mapResponse);

        return ApiResponse.ok(partida);
      }

      return ApiResponse.error(mapResponse["message"]);
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return ApiResponse.error(
          "Não foi possivel realizar o login erro inesperado");
    }
  }
}