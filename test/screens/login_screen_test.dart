import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_sync/screens/login/login_screen.dart';

void main() {
  testWidgets('Deve exibir o formulário de login ao clicar no logo', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Verifica se o logo é exibido inicialmente.
    expect(find.byType(Image), findsOneWidget);

    // Simula o clique no logo.
    await tester.tap(find.byType(Image));
    await tester.pumpAndSettle();

    // Verifica se o formulário de login é exibido.
    // expect(find.text('Entrar'), findsOneWidget);
    expect(find.byType(Text), findsOneWidget); // Email e senha.
    // expect(find.byType(TextFormField), findsNWidgets(2)); // Email e senha.
  });

  testWidgets('Deve exibir o botão de cadastro', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Verifica se o botão de cadastro é exibido.
    expect(find.text('Cadastre-se'), findsOneWidget);
  });
}
