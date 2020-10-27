import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/prefs.dart';

class JogadorApi {
  static Future<ApiResponse<Jogador>> insertJogador(Jogador jogador) async {
    try {
      var url = 'https://jogaaonde.com.br/jogador/cadastrar';
      String jsonUser = jsonEncode(jogador);
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await http.post(url, body: jsonUser, headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = Jogador.fromJson(mapResponse);

        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse["message"]);
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return ApiResponse.error(
          "Não foi possivel realizar o login erro inesperado");
    }
  }

  static Future<ApiResponse<Jogador>> atualizarJogador(Jogador jogador) async {
    try {
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/alterar';
      String jsonUser = jsonEncode(jogador);
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}"
      };

      final response = await http.put(url, body: jsonUser, headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = Jogador.fromJson(mapResponse);

        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse["message"]);
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return ApiResponse.error(
          "Não foi possivel realizar o login erro inesperado");
    }
  }

  static Future<Jogador> getJogador() async {
    try {
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/me';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);

      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final jogadors = Jogador.fromJson(jsonResponse["content"]);

        return jogadors;
      }

      return null;
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return null;
    }
  }

  static Future<List<Jogador>> getJogadorByNomeOrEmail(String nome) async {
    try {
      String token = await Prefs.getString("token");
      var url = 'https://jogaaonde.com.br/jogador/buscar?nome=$nome';
      if(nome.contains("@")){
         url = 'https://jogaaonde.com.br/jogador/buscar?email=$nome';
      }


      Map<String, String> headers = {"Authorization": "Bearer ${token}"};
      final response = await http.get(url, headers: headers);
      final jsonResponse = json.decode(response.body);
      final content = jsonResponse["content"];



      if (response.statusCode == 200) {
        final jogadors = content.map<Jogador>((map) => Jogador.fromJson(map)).toList();
        return jogadors;
      }

      return null;
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return null;
    }
  }

  static Future<List<Jogador>> getJogadoresByTimeId(String id) async {
    try {
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/time/buscar?id=$id';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);

      Map mapResponse = json.decode(response.body);
      final content = mapResponse["content"];

      List list = content[0]["integrantes"];

      if (response.statusCode == 200) {
        final quadras =
            list.map<Jogador>((map) => Jogador.fromJson(map)).toList();

        return quadras;
      }

      return null;
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return null;
    }
  }

//   static Future<List<Jogador>> getJogadorsPorNome(String nome) async {
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
//       final params = {"Action": "JogadorPorNome", "Nome": "$nome"};
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
// //      final user = Jogador.fromJson(retorno);
//       final jogadors =
//           list.map<Jogador>((map) => Jogador.fromJson(map)).toList();
//
//       var retornoResponse = false;
//
// //      Jogador tamanhos;
// //      list.forEach((element) {
// //        element = element;
// //        //json = element.map<Jogador>();
// //
// //        tamanhos = element.map<Jogador>((json) => Jogador.fromJson(json))
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
//       return jogadors;
//       //}
//
//     } catch (error, exception) {
//       print("erro no login $error > $exception");
//
//       //return error("Não foi possivel realizar o login erro inesperado");
//     }
//   }
}
