import 'dart:async';

import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_api.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/quadra/quadra_api.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/simple_bloc.dart';


class QuadraBloc extends SimpleBloc<List<Quadra>> {

  get stream => controller.stream;

  Future<List<Quadra>> getQuadraByEmpresa(String id) async {

    try {
      final response = await QuadraApi.getQuadraByEmpresa(id);

      add(response);

      return response;
    } catch (e) {
      addError(e);
    }
  }
}