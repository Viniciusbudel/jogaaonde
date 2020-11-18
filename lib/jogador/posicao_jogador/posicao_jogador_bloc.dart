import 'dart:async';

import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_api.dart';
import 'package:jogaaonde/jogador/posicao_jogador/posicao_jogador.dart';
import 'package:jogaaonde/jogador/posicao_jogador/posicao_jogador_api.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/simple_bloc.dart';

class PosicaoJogadorBloc extends SimpleBloc<List<PosicaoJogador>> {
  get stream => controller.stream;

  Future<List<PosicaoJogador>> getPosicaoJogador() async {

    List<PosicaoJogador> response = await PosicaoJogadorApi.getPosicaoJogador();

    add(response);

    return response;
  }
}
