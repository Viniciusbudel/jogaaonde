import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jogaaonde/login/login.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/prefs.dart';


class LoginApi {
  static Future<ApiResponse<Login>> login(String login, String senha) async {

    try {
      var url = 'https://jogaaonde.com.br/jogador/login';
      Map<String,String> headers = {"Content-Type" : "application/json"};

      final params = {"email": login, "senha": senha};

      String body = json.encode(params);

      final response = await http.post(url, body: body, headers: headers);


      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map mapResponse = json.decode(response.body);


      final id = mapResponse["content"]["me"]["id"];
      Prefs.setString("id", id.toString());


      if (response.statusCode == 200) {
        //final teste = mapResponse["content"];
        final login = Login.fromJson(mapResponse["content"]);

        return ApiResponse.ok(login);
      }

      return ApiResponse.error(mapResponse["message"]);

      return ApiResponse.error(mapResponse["error"]);
    }catch(error, exception){
      print("erro no login $error > $exception");

      return ApiResponse.error("Não foi possivel realizar o login erro inesperado");
    }
  }
}
