import 'dart:async';
import 'package:jogaaonde/partidas/partidas_recentes/partidas_recentes.dart';
import 'package:jogaaonde/partidas/partidas_recentes/partidas_recentes_api.dart';
import 'package:jogaaonde/utils/simple_bloc.dart';

class PartidasRecentesBloc extends SimpleBloc<List<PartidasRecentes>> {
  get stream => controller.stream;

  Future<List<PartidasRecentes>> getPartidasByTime(String time,bool proximas) async {
    try {
      final response = await PartidasRecentesApi.getPartidasByTime(time,proximas);

      add(response);


      return response;
    } catch (e) {
      addError(e);
    }
  }


  Future<List<PartidasRecentes>> getPartidasAtivasByCidade(String cidade) async {
    try {
      final response = await PartidasRecentesApi.getPartidasByCidade(cidade);

      add(response);

      return response;
    } catch (e) {
      addError(e);
    }
  }

}
