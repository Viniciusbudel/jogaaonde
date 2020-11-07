import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogaaonde/jogador/cadastro_jogador_page.dart';
import 'package:jogaaonde/home/home_page.dart';
import 'package:jogaaonde/login/login.dart';
import 'package:jogaaonde/login/login_bloc.dart';
import 'package:jogaaonde/utils/api_response.dart';
import 'package:jogaaonde/utils/custom_dialog.dart';
import 'package:jogaaonde/utils/prefs.dart';
import 'package:jogaaonde/utils/widgets/custom_button.dart';
import 'package:jogaaonde/utils/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF05290C),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _img("assets/images/logo_250.png"),
                      CustomTextField(
                          "Email", "Digite seu e-mail", _tLogin, Icons.email),
                      SizedBox(
                        height: 20.0,
                      ),
                      CustomTextField(
                        "Senha",
                        "Digite sua senha",
                        _tSenha,
                        Icons.lock,
                        senha: true,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CustomButton("LOGIN", _onClickLogin),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => push(context, CadastrarJogadorPage(null)),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Não tem uma conta? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Cadastre-se',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _img(String img) {
    return Image.asset(
      img,
      fit: BoxFit.cover,
      width: 280,
      height: 250,
    );
  }

  Future push(BuildContext context, Widget page) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) {
      return page;
    }));
  }

  _onClickLogin() async {
    String login = _tLogin.text;
    String senha = _tSenha.text;

    ApiResponse response = await _loginBloc.login(login, senha);
    Login l = response.result;

    if (response.ok) {
      Prefs.setString("token", l.token);
      push(context, HomePage());
    } else {
      DialogUtils.showCustomDialog(context,
          title: response.msg,
          okBtnText: "Ok",
          cancelBtnText: "",
          okBtnFunction: () => Navigator.pop(context) //Fazer algo
          //Fazer algo
          );
    }
  }
}
