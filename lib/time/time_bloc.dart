import 'dart:async';

import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_api.dart';
import 'package:jogaaonde/time/time.dart';
import 'package:jogaaonde/time/time_api.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/simple_bloc.dart';

class TimeBloc extends SimpleBloc<List<Time>> {
  get stream => controller.stream;

  Future<ApiResponse<Time>> inserirTime(Time c) async {
    //add(true);

    ApiResponse response = await TimeApi.insertTime(c);

    //add(false);

    return response;
  }

  Future<ApiResponse<Time>> addJogadorTime(String idJogador,idTime) async {
    //add(true);

    ApiResponse response = await TimeApi.addJogadorTime(idJogador,idTime);

    //add(false);

    return response;
  }

  Future<ApiResponse<Time>> updtaeTime(Time c) async {
    //add(true);

    ApiResponse response = await TimeApi.updateTime(c);

    //add(false);

    return response;
  }

  Future<List<Time>> listarTimes() async {
    try {
      List<Time> response = await TimeApi.getTime();

      add(response);

      return response;
    } catch (e) {
      addError(e);
    }
  }
  Future<List<Time>> listarTimesByCidade(String cidade) async {
    try {
      List<Time> response = await TimeApi.getTimeByCidade(cidade);

      add(response);

      return response;
    } catch (e) {
      addError(e);
    }
  }

// Future<List<Time>> listarTimesPorNome(String nome) async {
//   try {
//     List<Time> response = await TimeApi.getTimesPorNome(nome);
//
//     add(response);
//
//     return response;
//   } catch (e) {
//     addError(e);
//   }
// }
}
