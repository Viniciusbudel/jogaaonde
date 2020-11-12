import 'dart:async';
import 'package:jogaaonde/partidas/partidas_recentes/partidas_recentes.dart';
import 'package:jogaaonde/partidas/partidas_recentes/partidas_recentes_api.dart';
import 'package:jogaaonde/utils/simple_bloc.dart';

class PartidasRecentesBloc extends SimpleBloc<List<PartidasRecentes>> {
  get stream => controller.stream;

  Future<List<PartidasRecentes>> getPartidasRecentesByTime(String time) async {
    final response = await PartidasRecentesApi.getPartidasRecentesByTime(time);

    add(response);

    return response;
  }

  Future<List<PartidasRecentes>> getPartidasAtivasByCidade(String cidade) async {
    final response = await PartidasRecentesApi.getPartidasByCidade(cidade);

    add(response);

    return response;
  }
}
