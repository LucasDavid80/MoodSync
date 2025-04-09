import 'package:flutter/material.dart';
import 'package:mood_sync/services/sing_up_service.dart';

import '../../shared/constants/custom_colors.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  bool queroEntrar = true;
  final TextEditingController _nameInputController = TextEditingController();
  final TextEditingController _mailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  final TextEditingController _confirmInputController = TextEditingController();

  final SignUpService _authService = SignUpService();

  bool showPassword = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      height: MediaQuery.of(context).size.height * .85,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            CustomColors().getGradientSecColor(),
            CustomColors().getGradientMainColor(),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Text(
                'Cadastre-se! ;)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameInputController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      final exp = RegExp(r"^[a-zA-Z ]{8,}$");
                      if (!exp.hasMatch(text!)) {
                        return 'Nome Inválido';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Nome Completo',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.person, color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _mailInputController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      final exp = RegExp(
                        r"^\w{5,}(.)*@(gmail|yahoo|outlook)(.com)(.br)*$",
                      );
                      if (!exp.hasMatch(text!)) {
                        return 'Email Inválido';
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
                    obscureText: (showPassword) ? false : true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      final exp = RegExp(r"^[a-zA-Z0-9]{6,}");
                      if (!exp.hasMatch(text!)) {
                        return 'A senha deve ter pelo menos 6 caracteres';
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
                  (showPassword == false)
                      ? TextFormField(
                        controller: _confirmInputController,
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (text) {
                          if (text != _passwordInputController.text) {
                            return 'As senhas não estão iguais';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Confirme a senha',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.key, color: Colors.white),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      )
                      : Container(),
                  Row(
                    children: [
                      Checkbox(
                        value: showPassword,
                        onChanged: (bool? newValue) {
                          setState(() {
                            showPassword = newValue!;
                          });
                        },
                        side: const BorderSide(color: Colors.white),
                      ),
                      const Text(
                        'Mostrar a senha',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
                backgroundColor: WidgetStateProperty.all<Color>(
                  CustomColors().getActivePrimaryButtonColor(),
                ),
                shape: WidgetStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              onPressed: () {
                _doSingUp();
              },
              child: const Text('Cadastrar', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  void _doSingUp() {
    String nome = _nameInputController.text;
    String email = _mailInputController.text;
    String password = _passwordInputController.text;
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _authService
          .registerUser(name: nome, email: email, password: password)
          .then((String? error) {
            if (!mounted) return; // Verifica se o widget ainda está montado
            if (error != null) {
              // Deu ruim
              SnackBar snackBar = SnackBar(
                content: Text(error),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                ),
                duration: Duration(seconds: 4),
                action: SnackBarAction(
                  label: 'Dispensar',
                  textColor: Colors.white,
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          });
    }
    if (mounted) {
      Navigator.pop(context); // Verifica novamente antes de usar o contexto
    }
  }
}
