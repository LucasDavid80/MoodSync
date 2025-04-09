import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mood_sync/screens/diary_screen.dart';
import 'package:mood_sync/screens/login/login_screen.dart';
import '../mocks/mock_firebase.mocks.dart';

void main() {
  // Declaração tardia de um mock para FirebaseAuth.
  late MockFirebaseAuth mockFirebaseAuth;
  // Declaração tardia de um mock para UserCredential.
  late MockUserCredential mockUserCredential;
  // Declaração tardia de um mock para User.
  late MockUser mockUser;

  // Configuração inicial antes de cada teste.
  setUp(() {
    // Inicializa o mock de FirebaseAuth.
    mockFirebaseAuth = MockFirebaseAuth();
    // Inicializa o mock de UserCredential.
    mockUserCredential = MockUserCredential();
    // Inicializa o mock de User.
    mockUser = MockUser();

    // Configura o retorno da propriedade displayName no mockUser.
    when(mockUser.displayName).thenReturn('Test User');
    // Configura o retorno da propriedade email no mockUser.
    when(mockUser.email).thenReturn('teste@email.com');
    // Configura o retorno da propriedade password no mockUser.
    // when(mockUser.password).thenReturn('123456');
  });

  test('Deve verificar se o usuário já está logado', () async {
    // Simula o retorno de um usuário logado.
    when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
    // Verifica se o usuário está logado.
    expect(mockFirebaseAuth.currentUser, isNotNull);
  });

  /*testWidgets(
    'Deve redirecionar para DiaryScreen se o usuário estiver autenticado',
    (WidgetTester tester) async {
      // Simula um usuário autenticado.
      when(
        mockFirebaseAuth.userChanges(),
      ).thenAnswer((_) => Stream.value(mockUser));

      // Adiciona um tearDown para garantir que o Stream seja encerrado.
      addTearDown(() {
        mockFirebaseAuth.userChanges().drain(); // Encerra o Stream.
      });

      // Renderiza o StreamBuilder dentro de um MaterialApp.
      await tester.pumpWidget(
        MaterialApp(
          home: StreamBuilder<User?>(
            stream: mockFirebaseAuth.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DiaryScreen(user: snapshot.data!);
              } else {
                return LoginPage();
              }
            },
          ),
        ),
      );

      // Aguarda a reconstrução do StreamBuilder.
      await tester.pump();

      // Verifica se a tela de diário foi carregada.
      expect(find.byType(DiaryScreen), findsOneWidget);
      expect(find.byType(LoginPage), findsNothing);
    },
  );*/

  test('Deve verificar se o usuário não está logado', () async {
    // Simula o retorno de um usuário não logado.
    when(mockFirebaseAuth.currentUser).thenReturn(null);
    // Verifica se o usuário não está logado.
    expect(mockFirebaseAuth.currentUser, isNull);
  });

  testWidgets(
    'Deve redirecionar para LoginPage se o usuário não estiver autenticado',
    (WidgetTester tester) async {
      // Simula um usuário não autenticado.
      when(
        mockFirebaseAuth.userChanges(),
      ).thenAnswer((_) => Stream.value(null));

      // Renderiza o StreamBuilder dentro de um MaterialApp.
      await tester.pumpWidget(
        MaterialApp(
          home: StreamBuilder<User?>(
            stream: mockFirebaseAuth.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DiaryScreen(user: snapshot.data!);
              } else {
                return LoginPage();
              }
            },
          ),
        ),
      );

      // Aguarda a reconstrução do StreamBuilder.
      await tester.pump();

      // Verifica se a tela de login foi carregada.
      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(DiaryScreen), findsNothing);
    },
  );
}
