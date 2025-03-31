import 'package:flutter/material.dart';

import '../../shared/constants/custom_colors.dart';
import 'widgets/login_form.dart';
import 'widgets/login_signup_invite.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool animLogo = false;
  bool animForm = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 150)).then((_) {
      setState(() {
        animLogo = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          // width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                CustomColors().getGradientMainColor(),
                CustomColors().getGradientSecColor(),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 800),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            animForm = !animForm;
                          });
                        },
                        child: AnimatedContainer(
                          height: (!animLogo) ? 0 : 200,
                          duration: const Duration(milliseconds: 800),
                          child: Image.asset(
                            'assets/images/Logo.jpg',
                            height: 150,
                          ),
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Visibility(
                    visible: !animForm,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 800),
                      opacity: (!animLogo) ? 0 : 1,
                      child: const Text(
                        'Clique para começar',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  margin: const EdgeInsets.only(top: 10),
                  duration: const Duration(milliseconds: 2000),
                  height:
                      (!animForm) ? 0 : MediaQuery.of(context).size.height * .5,
                  child: Visibility(
                    visible: animForm,
                    child: ListView(
                      children: const [
                        Text(
                          'Entrar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        LoginForm(),
                        LoginSignUpInvite(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  // Future<LoginModel> _getSavedUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String jsonUser = prefs.getString(PreferencesKeys.activeUser)!;

  //   Map<String, dynamic> mapUser = json.decode(jsonUser);

  //   LoginModel user = LoginModel.fromJson(mapUser);
  //   return user;
  // }
}
