import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_sync/screens/sign_up/sign_up_page.dart';

void main() {
  testWidgets('Deve exibir mensagem de sucesso ao cadastrar usuário', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: SingUpPage()));

    // Preencha os campos
    await tester.enterText(find.byKey(Key('nameInput')), 'Teste');
    await tester.enterText(find.byKey(Key('emailInput')), 'teste@email.com');
    await tester.enterText(find.byKey(Key('passwordInput')), '123456');

    // Toque no botão de cadastro
    await tester.tap(find.byKey(Key('signUpButton')));
    await tester.pump();

    // Verifique se o SnackBar foi exibido
    expect(find.text('Usuário cadastrado com sucesso!'), findsOneWidget);
  });
}
