import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jogaaonde/partidas/marcar_partida/horario_partida/horario_partida.dart';
import 'package:jogaaonde/utils/prefs.dart';

class HorarioPartidaApi {

  static Future<List<HorarioPartida>> getHorarioPartida(data,idQuadra) async {
    try {
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/horario_quadra/buscar?quadra_id=$idQuadra&data_abertura=$data';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);
      Map mapResponse = json.decode(response.body);
      List list = mapResponse["content"];

      if (response.statusCode == 200) {
        final quadras = list
            .map<HorarioPartida>((map) => HorarioPartida.fromJson(map))
            .toList();

        return quadras;
      }

      return throw Exception("Erro ao buscar");
    } catch (error, exception) {
      print("erro no login $error > $exception");
      return null;
    }
  }
}
