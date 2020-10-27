import 'dart:async';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/simple_bloc.dart';
import 'login.dart';
import 'login_api.dart';


class LoginBloc extends SimpleBloc<bool>{

  get stream => controller.stream;

  Future<ApiResponse<Login>> login(String login, String senha) async {
    try {
      add(true);

      ApiResponse response = await LoginApi.login(login, senha);

      add(false);

      return response;
    } catch (e) {
      print(e);
    }
  }


}