import 'package:flutter/material.dart';

import '../../../shared/constants/custom_colors.dart';
import '../../../services/login_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _mailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();

  bool _obscurePassword = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _mailInputController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              final exp = RegExp(
                r"^\w{5,}(.)@(gmail|yahoo|outlook)(.com)(.br)*$",
              );
              if (exp.hasMatch(text ?? '')) {
                return 'Esse e-mail está meio estranho, não?';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'E-mail',
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.mail_outline, color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          TextFormField(
            controller: _passwordInputController,
            obscureText: !_obscurePassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              final exp = RegExp(r"^[a-zA-Z]{8,}$");
              if (exp.hasMatch(text ?? '')) {
                return 'A senha deve ter pelo menos 8 caracteres';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Senha',
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.key, color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {},
          //   child: const Text(
          //     'Esqueceu a senha?',
          //     textAlign: TextAlign.right,
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 12,
          //     ),
          //   ),
          // ),
          Row(
            children: [
              Checkbox(
                value: _obscurePassword,
                onChanged: (bool? newValue) {
                  setState(() {
                    _obscurePassword = newValue!;
                  });
                },
                side: const BorderSide(color: Colors.white),
              ),
              const Text(
                'Mostrar senha',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
              backgroundColor: WidgetStateProperty.all<Color>(
                CustomColors().getActivePrimaryButtonColor(),
              ),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
            onPressed: () {
              _doLogin();
            },
            child: const Text('Login', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  void _doLogin() async {
    if (_formKey.currentState!.validate()) {
      bool validacao = LoginService().login(
        _mailInputController.text,
        _passwordInputController.text,
      );
      if (validacao) {
        // Navegar para a Calendar
        Navigator.pushReplacementNamed(context, '/diary');
      }
    } else {
      print('Deu ruim!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      // ignore: avoid_print
      print('Inválido');
    }
    //EXEMPLOS
    // String mailForm = _mailInputController.text;
    // String passForm = _passwordInputController.text;

    // LoginModel savedUser = await _getSavedUser();

    // if (mailForm == savedUser.mail && passForm == savedUser.password) {
    //   // ignore: avoid_print
    //   print("Login efetuado com sucesso!!");
    // } else {
    //   // ignore: avoid_print
    //   print("Falha no login!");
    // }
  }
}
