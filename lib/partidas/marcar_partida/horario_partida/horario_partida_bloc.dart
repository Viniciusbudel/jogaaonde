import 'dart:async';
import 'package:jogaaonde/partidas/marcar_partida/horario_partida/horario_partida.dart';
import 'package:jogaaonde/partidas/marcar_partida/horario_partida/horario_partida_api.dart';
import 'package:jogaaonde/utils/simple_bloc.dart';

class HorarioPartidaBloc extends SimpleBloc<List<HorarioPartida>> {
  get stream => controller.stream;

  Future<List<HorarioPartida>> getHorarioPartida(String data,String idQuadra) async {

    List<HorarioPartida> response = await HorarioPartidaApi.getHorarioPartida(data,idQuadra);

    add(response);

    return response;
  }
}
