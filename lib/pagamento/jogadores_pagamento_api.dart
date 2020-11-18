import 'dart:convert';

import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/pagamento/jogadores_pagamento.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/prefs.dart';
import 'package:http/http.dart' as http;

class JogadorPagamentoApi {
  static Future<List<JogadorPagamento>> getJogadorPagamentoByPartidaId(
      String id) async {
    try {
      String token = await Prefs.getString("token");

      var url =
          'https://jogaaonde.com.br/jogador/pagamento/buscar?partida_id=$id';

      Map<String, String> headers = {"Authorization": "Bearer ${token}"};

      final response = await http.get(url, headers: headers);

      Map mapResponse = json.decode(response.body);
      List list = mapResponse["content"];

      if (response.statusCode == 200) {
        final quadras = list
            .map<JogadorPagamento>((map) => JogadorPagamento.fromJson(map))
            .toList();

        return quadras;
      }

      return throw Exception("Erro ao buscar");
    } catch (error, exception) {
      print("erro no login $error > $exception");

      return throw Exception("Erro ao buscar");
    }
  }

  static Future<ApiResponse<JogadorPagamento>> insertPagamento(
      int pagamentoId) async {
    try {
      String token = await Prefs.getString("token");

      var url = 'https://jogaaonde.com.br/jogador/pagamento/confirmar';

      final params = {"pagamento_id": pagamentoId};
      String body = json.encode(params);

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}"
      };

      final response = await http.post(url, body: body, headers: headers);

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.ok(null);
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
