import 'dart:async';

import 'package:jogaaonde/empresa/empresa.dart';
import 'package:jogaaonde/empresa/empresa_api.dart';
import 'package:jogaaonde/jogador/jogador.dart';
import 'package:jogaaonde/jogador/jogador_api.dart';
import 'package:jogaaonde/quadra/quadra.dart';
import 'package:jogaaonde/quadra/quadra_api.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/simple_bloc.dart';


class EmpresaBloc extends SimpleBloc<List<Empresa>> {

  get stream => controller.stream;

  Future<List<Empresa>> getEmpresaByCidade(String cidade) async {

    final response = await EmpresaApi.getEmpresaByCidade(cidade);

    add(response);

    return response;
  }

  // Future<List<Empresa>> listarEmpresas() async {
  //   try {
  //     List<Empresa> response = await EmpresaApi.getEmpresas();
  //
  //     add(response);
  //
  //     return response;
  //   } catch (e) {
  //     addError(e);
  //   }
  // }
  // Future<List<Empresa>> listarEmpresasPorNome(String nome) async {
  //   try {
  //     List<Empresa> response = await EmpresaApi.getEmpresasPorNome(nome);
  //
  //     add(response);
  //
  //     return response;
  //   } catch (e) {
  //     addError(e);
  //   }
  // }
}