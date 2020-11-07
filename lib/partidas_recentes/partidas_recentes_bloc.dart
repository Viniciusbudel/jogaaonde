import 'dart:async';

import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/empresa/empresa_api.dart';
import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_api.dart';
import 'package:jogaaonde/partidas_recentes/partidas_recentes.dart';
import 'package:jogaaonde/partidas_recentes/partidas_recentes_api.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/quadra/quadra_api.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/simple_bloc.dart';


class PartidasRecentesBloc extends SimpleBloc<List<PartidasRecentes>> {

  get stream => controller.stream;

  Future<List<PartidasRecentes>> getPartidasRecentesByTime(String time) async {

    final response = await PartidasRecentesApi.getPartidasRecentesByTime(time);

    add(response);

    return response;
  }
  
}