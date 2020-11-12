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

      if (response.statusCode == 200) {
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

      return null;
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return null;
    }
  }

  static Future<List<Time>> getTimeByCidade(String cidade) async {
    try {
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/time/buscar?cidade=$cidade';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);

      Map mapResponse = json.decode(response.body);
      List list = mapResponse["content"];

      if (response.statusCode == 200) {
        final quadras = list.map<Time>((map) => Time.fromJson(map)).toList();

        return quadras;
      }

      return null;
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return null;
    }
  }

  static Future<ApiResponse<Time>> addJogadorTime(
      String idJogador, String idTime) async {
    try {
      String token = await Prefs.getString("token");

      final params = {"jogador_id": idJogador, "time_id": idTime};

      var url = 'https://jogaaonde.com.br/jogador/time/add_jogador';

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

//   static Future<List<Time>> getTimesPorNome(String nome) async {
//     try {
//       String token = await Prefs.getString("token");
//
//       final _configDAO = ConfiguracaoDAO();
//       Configuracao configuracao = await _configDAO.findById(1);
//       String url1 = "";
//       if (configuracao != null) {
//         url1 = configuracao.url;
//       }
//
//       var url = 'http://' +
//           url1 +
//           '/scps-mobile/sincronizacao/send-data?XDEBUG_SESSION_START=11447';
//
//       final params = {"Action": "TimePorNome", "Nome": "$nome"};
//
//       print("> Pedido Post POST: $url");
//       print("> Params: $params");
//
//       Map<String, String> headers = {"Authorization": "Bearer ${token}"};
//
//       final response = await http.post(url, body: params, headers: headers);
//
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//
//       //Map mapResponse = json.decode(response.body);
//       final map = convert.json.decode(response.body);
//
//       //List list = convert.json.decode(response.body);
//
//       List list = map["Retorno"];
//
// //      final user = Time.fromJson(retorno);
//       final times =
//           list.map<Time>((map) => Time.fromJson(map)).toList();
//
//       var retornoResponse = false;
//
// //      Time tamanhos;
// //      list.forEach((element) {
// //        element = element;
// //        //json = element.map<Time>();
// //
// //        tamanhos = element.map<Time>((json) => Time.fromJson(json))
// //            .toList();
// //        retornoResponse = true;
// //      });
//       //if (response.statusCode == 200) {
// //        user.save();
//
// //        Usuario  user2 = await Usuario.get();
//
//       //print("usuario2 $user2");
//
//       return times;
//       //}
//
//     } catch (error, exception) {
//       print("erro no login $error > $exception");
//
//       //return error("Não foi possivel realizar o login erro inesperado");
//     }
//   }
}
