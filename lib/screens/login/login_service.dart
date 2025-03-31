class LoginService {
  login(String mail, String password) /*async*/ {
    if (mail == 'lucas@gmail.com' && password == '123456') {
      print('Login efetuado com sucesso!');
      return true;
    }
    return false;
    // http.Response response = await http.post(
    //   Uri.parse(Routes.login),
    //   body: json.encode(
    //     {
    //       "email": mail,
    //       "password": password,
    //       "returnSecureToken": true,
    //     },
    //   ),
    // );
  }
}
