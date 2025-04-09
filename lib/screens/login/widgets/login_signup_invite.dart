import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../shared/constants/custom_colors.dart';
import '../../sign_up/sign_up_screen.dart';

class LoginSignUpInvite extends StatefulWidget {
  const LoginSignUpInvite({super.key});

  @override
  State<LoginSignUpInvite> createState() => _LoginSignUpInviteState();
}

class _LoginSignUpInviteState extends State<LoginSignUpInvite> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(color: Colors.black),
        ),
        const Text(
          'Ainda não tem uma conta?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ElevatedButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
              backgroundColor: WidgetStateProperty.all(
                CustomColors().getActiveSecondaryButtonColor(),
              ),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
            onPressed: () {
              showBarModalBottomSheet(
                context: context,
                builder: (context) {
                  return const SingUpScreen();
                },
              );
            },
            child: const Text('Cadastre-se', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
