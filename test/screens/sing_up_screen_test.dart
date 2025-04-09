import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_sync/screens/sign_up/sign_up_screen.dart';

import '../mocks/mock_firebase.mocks.dart';

void main() {
  group('SingUpPage Tests', () {
    late MockFirebaseAuth
    mockFirebaseAuth; // Declaração tardia de um mock para FirebaseAuth.
    late MockUserCredential
    mockUserCredential; // Declaração tardia de um mock para UserCredential.

    // Configuração inicial antes de cada teste.
    setUp(() {
      // Inicializa o mock de FirebaseAuth.
      mockFirebaseAuth = MockFirebaseAuth();
      // Inicializa o mock de UserCredential.
      mockUserCredential = MockUserCredential();
    });

    testWidgets('Deve exibir erro ao deixar campos vazios', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: SingUpScreen()));

      // Toque no botão de cadastro sem preencher os campos
      await tester.tap(find.text('Cadastrar'));
      await tester.pump();

      // Verifique se os erros de validação são exibidos
      expect(find.text('Nome Inválido'), findsOneWidget);
      expect(find.text('Email Inválido'), findsOneWidget);
      expect(
        find.text('A senha deve ter pelo menos 6 caracteres'),
        findsOneWidget,
      );
    });

    testWidgets('Deve exibir erro ao inserir senhas diferentes', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: SingUpScreen()));

      // Preencha os campos
      await tester.enterText(find.byType(TextFormField).at(0), 'Teste Nome');
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'teste@email.com',
      );
      await tester.enterText(find.byType(TextFormField).at(2), '123456');
      await tester.enterText(find.byType(TextFormField).at(3), '654321');

      // Toque no botão de cadastro
      await tester.tap(find.text('Cadastrar'));
      await tester.pump();

      // Verifique se o erro de senhas diferentes é exibido
      expect(find.text('As senhas não estão iguais'), findsOneWidget);
    });

    testWidgets('Deve exibir mensagem de sucesso ao cadastrar usuário', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: SingUpScreen()));

      // Preencha os campos
      await tester.enterText(find.byType(TextFormField).at(0), 'Teste Nome');
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'teste@email.com',
      );
      await tester.enterText(find.byType(TextFormField).at(2), '123456');
      await tester.enterText(find.byType(TextFormField).at(3), '123456');

      // Toque no botão de cadastro
      await tester.tap(find.text('Cadastrar'));
      await tester.pump();
    });
  });
}
