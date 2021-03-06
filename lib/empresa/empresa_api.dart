import 'dart:convert';

import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/prefs.dart';
import 'package:http/http.dart' as http;

class EmpresaApi{

  static Future<List<Empresa>> getEmpresaByCidade(String cidade) async {
    try{
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/empresa/buscar?cidade=$cidade';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);

      Map mapResponse = json.decode(response.body);
      List list = mapResponse["content"];

      if (response.statusCode == 200) {
        final quadras = list.map<Empresa>((map) => Empresa.fromJson(map)).toList();


        return quadras;
      }

      return throw Exception("Erro ao buscar");
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return throw Exception("Erro ao buscar");
    }
  }
}