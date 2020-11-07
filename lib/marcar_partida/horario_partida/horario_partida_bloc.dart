import 'dart:async';

import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_api.dart';
import 'package:jogaaonde/jogador/posicao_jogador/posicao_jogador.dart';
import 'package:jogaaonde/jogador/posicao_jogador/posicao_jogador_api.dart';
import 'package:jogaaonde/marcar_partida/horario_partida/horario_partida.dart';
import 'package:jogaaonde/marcar_partida/horario_partida/horario_partida_api.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/simple_bloc.dart';

class HorarioPartidaBloc extends SimpleBloc<List<HorarioPartida>> {
  get stream => controller.stream;

  Future<List<HorarioPartida>> getHorarioPartida(String data) async {

    List<HorarioPartida> response = await HorarioPartidaApi.getHorarioPartida(data);

    add(response);

    return response;
  }
}
