import 'dart:async';

import 'package:jogaaonde/campeonato/campeonato.dart';
import 'package:jogaaonde/campeonato/campeonato_api.dart';
import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/empresa/empresa_api.dart';
import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_api.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/quadra/quadra_api.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/simple_bloc.dart';


class CampeonatoBloc extends SimpleBloc<List<Campeonato>> {

  get stream => controller.stream;

  Future<List<Campeonato>> getCampeonatoByCidade(String cidade) async {

    try {
      final response = await CampeonatoApi.getCampeonatoByCidade(cidade);

      add(response);

      return response;
    } catch (e) {
      addError(e);
    }
  }

  Future<ApiResponse<Campeonato>> insertTimeCampeonato(String idTime,idCampeonato) async {
    //add(true);

    ApiResponse response = await CampeonatoApi.insertTimeCampeonato(idTime,idCampeonato);

    //add(false);

    return response;
  }
  // Future<List<Campeonato>> listarCampeonatosPorNome(String nome) async {
  //   try {
  //     List<Campeonato> response = await CampeonatoApi.getCampeonatosPorNome(nome);
  //
  //     add(response);
  //
  //     return response;
  //   } catch (e) {
  //     addError(e);
  //   }
  // }
}