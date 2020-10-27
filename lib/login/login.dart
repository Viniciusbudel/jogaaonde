
class Login {
  String login;
  String id;
  String senha;
  String token;

  bool status;
  String msg;

  Login.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
  }


  toMap(){
    return {
      "login": login,
      "senha": senha,
      "token": token
    };
  }
}