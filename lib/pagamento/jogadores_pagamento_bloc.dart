import 'dart:async';

import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/empresa/empresa_api.dart';
import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_api.dart';
import 'package:jogaaonde/pagamento/jogadores_pagamento.dart';
import 'package:jogaaonde/pagamento/jogadores_pagamento_api.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/quadra/quadra_api.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/simple_bloc.dart';


class JogadorPagamentoBloc extends SimpleBloc<List<JogadorPagamento>> {

  get stream => controller.stream;

  Future<List<JogadorPagamento>> getJogadorPagamentoByPartidaId(String id) async {

    try {
      final response = await JogadorPagamentoApi.getJogadorPagamentoByPartidaId(id);

      add(response);

      return response;
    } catch (e) {
      addError(e);
    }
  }

  // Future<List<JogadorPagamento>> listarJogadorPagamentos() async {
  //   try {
  //     List<JogadorPagamento> response = await JogadorPagamentoApi.getJogadorPagamentos();
  //
  //     add(response);
  //
  //     return response;
  //   } catch (e) {
  //     addError(e);
  //   }
  // }
  // Future<List<JogadorPagamento>> listarJogadorPagamentosPorNome(String nome) async {
  //   try {
  //     List<JogadorPagamento> response = await JogadorPagamentoApi.getJogadorPagamentosPorNome(nome);
  //
  //     add(response);
  //
  //     return response;
  //   } catch (e) {
  //     addError(e);
  //   }
  // }
}