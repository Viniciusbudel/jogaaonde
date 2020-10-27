import 'dart:async';

import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_api.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/quadra/quadra_api.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/simple_bloc.dart';


class QuadraBloc extends SimpleBloc<List<Quadra>> {

  get stream => controller.stream;

  Future<List<Quadra>> getQuadra() async {

    final response = await QuadraApi.getQuadra();

    add(response);

    return response;
  }

  // Future<List<Quadra>> listarQuadras() async {
  //   try {
  //     List<Quadra> response = await QuadraApi.getQuadras();
  //
  //     add(response);
  //
  //     return response;
  //   } catch (e) {
  //     addError(e);
  //   }
  // }
  // Future<List<Quadra>> listarQuadrasPorNome(String nome) async {
  //   try {
  //     List<Quadra> response = await QuadraApi.getQuadrasPorNome(nome);
  //
  //     add(response);
  //
  //     return response;
  //   } catch (e) {
  //     addError(e);
  //   }
  // }
}