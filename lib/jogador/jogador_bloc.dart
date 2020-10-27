import 'dart:async';

import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_api.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/simple_bloc.dart';

class JogadorBloc extends SimpleBloc<List<Jogador>> {
  get stream => controller.stream;

  Future<ApiResponse<Jogador>> inserirJogador(Jogador c) async {
    //add(true);

    ApiResponse response = await JogadorApi.insertJogador(c);

    //add(false);

    return response;
  }

  Future<ApiResponse<Jogador>> atualizarJogador(Jogador c) async {
    //add(true);

    ApiResponse response = await JogadorApi.atualizarJogador(c);

    //add(false);

    return response;
  }

  Future<Jogador> getJogador() async {
    final response = await JogadorApi.getJogador();

    //add(response);

    return response;
  }

  Future<List<Jogador>> getJogadoresByTimeId(String id) async {
    final response = await JogadorApi.getJogadoresByTimeId(id);

    add(response);

    return response;
  }

  Future<List<Jogador>> getJogadoresByNomeOrEmail(String nome) async {
    final response = await JogadorApi.getJogadorByNomeOrEmail(nome);

    add(response);

    return response;
  }
}
